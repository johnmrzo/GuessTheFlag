//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Bakhtiyorjon Mirzajonov on 10/19/23.
//

import SwiftUI

struct FlagImage: View {
    var imageName: String

    var body: some View {
        Image(imageName)
            .clipShape(Capsule())
            .shadow(radius: 5)
    }
}

struct ContentView: View {
  @State private var countries = ["Estonia", "France", "Germany", "Irelend", "Italy", "Nigeria", "Poland", "Spain", "Ukraine", "UK", "US"].shuffled()
  @State private var correctAnswer = Int.random(in: 0...2)
  
  @State private var showingScore = false
  @State private var scoreTitle = ""
  @State private var score = 0
  
  @State private var gameRounds = 8
  @State private var gameOver = false

  var body: some View {
    ZStack {
      RadialGradient(stops: [
        .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
        .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
      ], center: .top, startRadius: 200, endRadius: 700)
        .ignoresSafeArea()
      VStack {
        
        Spacer()
        
        Text("Guess the flag")
          .font(.largeTitle.bold())
          .foregroundStyle(.white)
        
        VStack(spacing: 15) {
          VStack {
            Text("Tap the flag of")
              .foregroundStyle(.secondary)
              .font(.subheadline.weight(.heavy))
            
            Text(countries[correctAnswer])
              .font(.largeTitle.weight(.semibold))
            
          }
          
          ForEach(0..<3) { number in
            Button {
              flagTapped(number)
            } label: {
              FlagImage(imageName: countries[number])
            }
          }
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .background(.regularMaterial)
        .clipShape(.rect(cornerRadius: 20))
        
        Spacer()
        Spacer()
        
        HStack {
          Text("Rounds: \(gameRounds)")
          Spacer()
          Text("Score: \(score)")
        }
        .padding()
        .foregroundStyle(.white)
        .font(.title.bold())
        
        Spacer()
      }
      .padding()
    }
    .alert(scoreTitle, isPresented: $showingScore) {
      Button("Continue", action: askQuestion)
    } message: {
      Text("Your score is \(score)")
    }
    .alert("Game is over!", isPresented: $gameOver) {
      Button("Restart", role: .cancel, action: restart)
    } message: {
      Text("Your score is \(score)")
    }
  }
  
  func flagTapped(_ number: Int) {
    if number == correctAnswer {
      scoreTitle = "Correct"
      score += 1
    } else {
      scoreTitle = "Wrong! That’s the flag of \(countries[number])."
    }
    
    showingScore = true
    
    gameRounds -= 1
    if gameRounds == 0 {
      gameOver = true
      showingScore = false
    }
  }
  
  func askQuestion() {
    countries.shuffle()
    correctAnswer = Int.random(in: 0...2)
  }
  
  func restart() {
    score = 0
    gameRounds = 8
    gameOver = false
  }
}

#Preview {
    ContentView()
}
