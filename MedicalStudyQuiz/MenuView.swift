//  MenuView.swift
//  Displays the menu screen using SwiftUI
//  Created by James Berry on 22/12/2022.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        NavigationView {
            ZStack{
                // Background image
                Image("gbg")
                    .resizable()
                    .aspectRatio(contentMode: ContentMode.fill)
                    .ignoresSafeArea()
                
                VStack {
                    // Text
                    ReusableText(text: "Medical Study Quiz!", size: 30)
                        .foregroundColor(Color.white)
                   Spacer()
                    // Stethoscope image
                    Image("clipart")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height/3)
                    Spacer()
                    HStack{
                        // Button to take the user to the quiz
                        NavigationLink(destination: ContentView()) {
                            // Text
                            Text("Play Quiz")
                                .frame(minWidth: 0, maxWidth: 300)
                                .padding()
                                .foregroundColor(.white)
                               // .background(LinearGradient(gradient: Gradient(colors: [Color.mint]), startPoint: .leading, endPoint: .trailing))
                                .background(Color.green)
                                .cornerRadius(40)
                                .font(.title)
                        }
                        

                    }
                }
            }
            .preferredColorScheme(.dark)
        }
       
    }
}
