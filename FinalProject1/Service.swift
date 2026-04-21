//
//  Service.swift
//  FinalProject1
//
//  Created by Kyle Bublic on 4/8/26.
//

import Foundation

class WikiService {
    static func fetchRandomPage(count: Int = 4) async throws -> [WikiData] {
        // Use URLSession and JSONDecoder to make a GET request
        let urlString =
               "https://en.wikipedia.org/w/api.php?action=query&format=json&generator=random&grnnamespace=0&grnlimit=1&prop=pageimages&pithumbsize=500"
               let url = URL(string: urlString)!
        
        var results: [WikiData] = []
        
               for _ in 0..<10 {
                   let (data, _) = try await URLSession.shared.data(from: url)
                   let decoded = try JSONDecoder().decode(WikiResponse.self, from: data)
                   guard let firstPage = decoded.query.pages.first else {
                       continue
                   }
                   let pageID = firstPage.key
                   let page = firstPage.value
                   
                   if let thumbnailURL = page.thumbnail?.source {
                       
                       
                       let wiki = WikiData(
                           id: pageID,
                           title: page.title,
                           thumbnailURL: thumbnailURL)
                       
                       results.append(wiki)
                       
                       if results.count >= count{
                           return results
                       }
                   }
               }
               return results
           }
       }

