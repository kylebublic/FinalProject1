//
//  ContentView.swift
//  FinalProject1
//
//  Created by Kyle Bublic on 4/8/26.
//
import SwiftUI

struct ContentView: View {
    @State var wikiData: WikiData?
    
    var body: some View {
        List {
            Button("Generate Image") {
                // Add a Task to call getWords()
                Task {
                    do {
                        wikiData = try await WikiService.fetchRandomPage()}
                    catch {print(error.localizedDescription)}
                }
            }
            
            if let page = wikiData {
                
                Section("Image Information") {
                    
                    Text(page.title)
                    
                    if let urlString = page.thumbnailURL,
                       let url = URL(string: urlString){
                        AsyncImage(url:url){ image in image
                                .resizable()
                                .scaledToFit()
                            
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxHeight: 250)
                    }
                }
                
            }
            else{
                Text("Error Getting Image")
            }
        }
    }
}
    




#Preview {
    ContentView()
}
