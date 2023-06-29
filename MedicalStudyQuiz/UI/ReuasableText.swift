// ReusableText.swift
// Reusable text model
// Created by James Berry on 10/11/2022.

import Foundation
import SwiftUI

struct ReusableText: View {
    var text: String
    var size: CGFloat
    var body: some View {
        Text(text)
            .font(.system(size: size, weight: .bold, design: .rounded))
            .foregroundColor(.white)
            .shadow(color: Color.gray, radius: 2, x: 0, y: 3)
    }
}

