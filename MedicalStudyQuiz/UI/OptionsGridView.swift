// OptionsGridView.swift
// Options grid model which is used in ContentView which displays the 4 anwsers for the question
// Created by James Berry on 10/11/2022.

import Foundation
import SwiftUI


struct OptionsGridView: View {
    var gameManagerVM: GameManagerVM
    var columns: [GridItem] = Array(repeating: GridItem(.fixed(170), spacing: 0), count: 2)
    var body: some View {
        
        LazyVGrid(columns: columns, spacing: 20) {
            ForEach(gameManagerVM.model.quizModel.optionsList) {[weak gameManagerVM] quizOption in
                OptionCardView(quizOption: quizOption)
                    .onTapGesture {
                        gameManagerVM?.verifyAnswer(selectedOption: quizOption)
                    }
            }
        }
        
    }
    

}

struct OptionCardView : View {
    var quizOption: QuizOption
    var body: some View {
        VStack {
            // If the question is correct checkmark is displayed
            if (quizOption.isMatched) && (quizOption.isSelected) {
                OptionStatusImageView(imageName: "checkmark")
            // Else if the the question is wrong a cross is displayed
            } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
                OptionStatusImageView(imageName: "xmark")
            // Else no anwser is selected all the anwsers are displayed
            } else {
                OptionView(quizOption: quizOption)
            }
        }.frame(width: 150, height: 150)
            .background(setBackgroundColor())
            .cornerRadius(40)
    }
    
    func setBackgroundColor() -> Color {
        // If the question is correct the background colour turns green
        if (quizOption.isMatched) && (quizOption.isSelected) {
            return Color.green
        // Else if the question is wrong the background colour turns red
        } else if (!(quizOption.isMatched) && (quizOption.isSelected)) {
            return Color.red
        // Else no anwser is selected the colour is white
        } else {
            return Color.white
        }
    }
}

struct OptionView: View {
    var quizOption: QuizOption
    var body: some View {
        VStack{
            // Displays option id which is A, B, C, and D for the 4 sqaures options on the screen
            Text(quizOption.optionId)
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .frame(width: 50, height: 50)
                .background(quizOption.color.opacity(0.8))
                .foregroundColor(.white)
                .cornerRadius(25)
            // Displays the correct anwser with the option id
            Text(quizOption.option)
                .frame(width: 150, height: 38)
                .font(.system(size: 14, weight: .bold, design: .rounded)).multilineTextAlignment(.center)
                .foregroundColor(.black)
        }
    }
}

struct OptionStatusImageView: View {
    var imageName: String
    var body: some View {
        // Displays an image with an image name
        Image(systemName: imageName)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(EdgeInsets(top: 40, leading: 40, bottom: 40, trailing: 40))
            .foregroundColor(Color.white)
    }
}
