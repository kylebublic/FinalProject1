//
//  OpenPage.swift
//  FinalProject1
//
//  Created by Kyle Bublic on 4/18/26.
//

import SwiftUI

struct OpenPage: View {
    @Binding var showGame: Bool
    @State private var showSettings = false
    @Binding var themeColor: Color
    
    var body: some View {
        ZStack{
            Color(.systemGray5)
                .ignoresSafeArea()
           
            VStack{
                    Image("wiki_cool")
                        .resizable()
                        .frame(width:225, height: 200)
                        .padding()
                    Text("WikiGuessr")
                        .font(.title)
                        .fontWeight(.bold)
                        .padding()
                    Button{
                        showGame = true
                    } label: {
                        Text("Press to Start")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 20)
                                    .fill(themeColor))
                        
                    }
                    
                }
                Spacer()
            }
            
        .overlay(alignment: .top) {
            VStack {
                HStack { Text("Kyle's Game :)")
                        .font(.title)
                        .fontWeight(.bold)
                    Spacer()
                    
                    Button{
                        showSettings = true
                    }label: {
                        Image(systemName: "gearshape.fill")}
                    .fontWeight(.bold)
                    .foregroundStyle(themeColor)
                }
                
                .padding()
                
                Divider()
            }
        }
        .sheet(isPresented: $showSettings) {
            SettingsPage(showSettings: $showSettings, themeColor: $themeColor)}
        }
}
