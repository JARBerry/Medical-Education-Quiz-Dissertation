//
//  QuestionText.swift

//  MedicalStudyQuiz
// Created by James Berry on 10/11/2022.
//

import SwiftUI

struct QuestionText: View {
    var text: String
    var size: CGFloat
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: .bold, design: .rounded))
            .foregroundColor(.black)
            .padding()
            .background(Color.white)
            .cornerRadius(10)
    }
}


