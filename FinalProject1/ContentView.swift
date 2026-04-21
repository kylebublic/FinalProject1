//
//  ContentView.swift
//  FinalProject1
//
//  Created by Kyle Bublic on 4/8/26.
//
import SwiftUI

struct ContentView: View {
    @State var wikiData: WikiData?
    @State private var choices: [WikiData] = []
    @State private var correctAnswer: WikiData?
    @State private var selectedAnswer: String?
    @State private var showGame = false
    @State private var themeColor: Color = .orange
    @State private var streak = 0

    
    var body: some View {
        if showGame {
            gameView
        } else {
            OpenPage(showGame: $showGame, themeColor: $themeColor)
        }
    }
    var gameView: some View {
            GamePage(
                wikiData: $wikiData,
                choices: $choices,
                correctAnswer: $correctAnswer,
                selectedAnswer: $selectedAnswer,
                streak: $streak,
                themeColor: $themeColor,
                showGame: $showGame
            )
        }

  
    
}
    
    #Preview {
        ContentView()
    }

