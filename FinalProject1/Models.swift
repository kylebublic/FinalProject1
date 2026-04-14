//
//  Models.swift
//  FinalProject1
//
//  Created by Kyle Bublic on 4/8/26.
//

import Foundation

struct WikiResponse: Decodable {
        let query: WikiQuery
    }

struct WikiQuery: Decodable {
    let pages: [String: WikiPage]
}

struct WikiPage: Decodable {
    let title: String
    let thumbnail: Thumbnail?
}

struct Thumbnail: Decodable {
        let source: String
    }

struct WikiData {
    let id: String
    let title: String
    let thumbnailURL: String?
}

