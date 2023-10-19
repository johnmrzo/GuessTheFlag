//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bakhtiyorjon Mirzajonov on 10/19/23.
//

import SwiftUI

struct ContentView: View {
  var countires = ["Estonia", "France", "Germany", "Irelend", "Italy", "Nigeria", "Poland", "Spain", "Ukraine", "UK", "US"]
  var correctAnswer = Int.random(in: 0...2)
  
  
  var body: some View {
    ZStack {
      Color.blue
        .ignoresSafeArea()
      
      VStack(spacing: 30) {
        VStack {
          Text("Tap the flag of")
            .foregroundStyle(.white)
    
          Text(countires[correctAnswer])
            .foregroundStyle(.white)

        }
        
        ForEach(0..<3) { number in
          Button {
            
          } label: {
            Image(countires[number])
          }
        }
      }
    }
  }
}

#Preview {
    ContentView()
}
