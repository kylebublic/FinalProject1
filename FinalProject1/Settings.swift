//
//  Rules.swift
//  FinalProject1
//
//  Created by Kyle Bublic on 4/20/26.
//

import SwiftUI

struct SettingsPage: View {
    @Binding var showSettings: Bool
    @Binding var themeColor: Color
        
        var body: some View {
               VStack(spacing: 20) {
                   
                   Text("Choose your Theme")
                       .font(.title)
                       .fontWeight(.bold)
                   HStack(spacing: 20) {
                       
                       Button {
                           themeColor = .orange
                       } label: {
                           Circle().fill(Color.orange)
                       }
                       
                       Button {
                           themeColor = .blue
                       } label: {
                           Circle().fill(Color.blue)
                       }
                       
                       Button {
                           themeColor = .green
                       } label: {
                           Circle().fill(Color.green)
                       }
                       
                       Button {
                           themeColor = .purple
                       } label: {
                           Circle().fill(Color.purple)
                       }
                   }
                   
                   .frame(height: 50)
                   
                   Button("Back") {
                       showSettings = false
                   }
                   .padding()
                   .background(
                       RoundedRectangle(cornerRadius: 15)
                           .fill(themeColor)
                   )
                   .foregroundColor(.white)
               }
               .padding()
           }
       }

