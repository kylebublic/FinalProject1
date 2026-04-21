//
//  GamePage.swift
//  FinalProject1
//
//  Created by Kyle Bublic on 4/21/26.
//

import SwiftUI

struct GamePage: View {
    @Binding var wikiData: WikiData?
    @Binding var choices: [WikiData]
    @Binding var correctAnswer: WikiData?
    @Binding var selectedAnswer: String?
    @Binding var streak: Int
    @Binding var themeColor: Color
    @Binding var showGame: Bool
    
    
    var body: some View {
        List {
            if let page = wikiData {
                
                Section(header:
                            VStack{
                    HStack{
                        Button {
                            showGame = false }
                        label: {
                            Image(systemName: "house.circle.fill")
                                .font(.title)
                                .foregroundStyle(themeColor)
                        }
                        
                        Text("Image Information")
                            .font(.headline)
                        
                        Spacer()
                      
                        Text("🔥 Streak: \(streak)")
                            .font(.headline)
                            .foregroundStyle(themeColor)
                            .fontWeight(.bold)
                    }
                }
                        
                )
                {
                    
                    Text("What are you looking at?")
                        .fontWeight(.bold)
                    
                    if let urlString = page.thumbnailURL,
                       let url = URL(string: urlString) {
                        
                        AsyncImage(url: url) { image in
                            image.resizable().scaledToFit()
                        } placeholder: {
                            ProgressView()
                        }
                        .frame(maxHeight: 250)
                    }
                }
                
                Section("Which could it be...") {
                    ForEach(choices, id: \.id) { choice in
                        Button(choice.title) {
                            selectedAnswer = choice.title
                            if choice.title == correctAnswer?.title {
                                streak += 1
                            } else {
                                streak = 0}
                            Task {try? await Task.sleep(nanoseconds:1_000_000_000)
                                do {
                                    let pages = try await WikiService.fetchRandomPage()
                                    guard pages.count >= 3 else { return }
                                    
                                    correctAnswer = pages.first
                                    choices = Array(pages.prefix(3)).shuffled()
                                    wikiData = correctAnswer
                                    selectedAnswer = nil
                                    
                                } catch {
                                    print(error.localizedDescription)}
                            }
                        }
                        .disabled(selectedAnswer != nil)
                        .foregroundStyle(themeColor)
                        .fontWeight(.bold)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .fill(selectedAnswer == nil ? Color.clear : choice.title == correctAnswer?.title ? Color.green.opacity(0.5) :choice.title == selectedAnswer ? Color.red.opacity(0.5) : Color.clear)
                            
                        )
                    }
                }
                
                if let selected = selectedAnswer,
                   let correct = correctAnswer {
                    
                    Text(selected == correct.title ? "Correct" : "Incorrect")
                        .foregroundColor(selected == correct.title ? .green : .red)
                }
                
            } else {
                Text("Loading. . .")
            }
        }
        
        .onAppear {
            if wikiData == nil {
                Task {
                    do {
                        let pages = try await WikiService.fetchRandomPage()
                        guard pages.count >= 3 else { return }
                        
                        correctAnswer = pages.first
                        choices = Array(pages.prefix(3)).shuffled()
                        wikiData = correctAnswer
                        selectedAnswer = nil
                        
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        
        
    }
}
