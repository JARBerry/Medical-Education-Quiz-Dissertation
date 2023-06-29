// QuizCompletedView.swift
// Completed view model which is used in ContentView this is what is displayed in on the end screen
// Created by James Berry on 10/11/2022.

import Foundation
import SwiftUI

struct QuizCompletedView: View {
    var gameManagerVM: GameManagerVM
    var body: some View {
        VStack {
            // Displays score
            ReusableText(text: "Score is \(gameManagerVM.testIndex + 1)", size: 30)
            // Text("Score is \(gameManagerVM.testIndex)")
            Image(systemName: "gamecontroller.fill")
                .foregroundColor(Color.yellow)
                .font(.system(size: 60))
                .padding()
            
            // Displays game text
            ReusableText(text: gameManagerVM.model.quizWinningStatus ?
                         "THAT'S A WRAP" :
                            "GAME OVER",
                         size: 30)
                .padding()
            
            // displays more text for the end screen
           QuestionText(text: gameManagerVM.model.quizWinningStatus
                         ? "Thank you for playing!!"
                         : "Keep practising!!",
                         size: 30)
                .padding()
            
            
            Button {
                gameManagerVM.restartGame()
            } label: {
                HStack {
                    // displays games console image
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .padding()
                    // Displays play again text
                    Text("Play Again")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                }
            }.frame(width: 300, height: 60, alignment: .center)
               // .background(LinearGradient(gradient: Gradient(colors: [Color.mint]), startPoint: .leading, endPoint: .trailing))
                .background(Color.green)
                .cornerRadius(30)
                .padding()
            
        }
        .onDisappear{
            self.gameManagerVM.reset()
            self.gameManagerVM.restartGame()
        }
    }
}
