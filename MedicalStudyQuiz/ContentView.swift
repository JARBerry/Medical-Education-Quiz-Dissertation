// ContentView.swift
// Using SwiftUI this displays the quiz screen and the end screen
// Created by James Berry on 10/11/2022.


import SwiftUI

struct ContentView: View {
    @ObservedObject var gameManagerVM = GameManagerVM()
    
    
    var body: some View {
        
        ZStack {
            // Background image
            Image("gbg")
                .resizable()
                .aspectRatio(contentMode: ContentMode.fill)
                .ignoresSafeArea()
            
            if (gameManagerVM.model.quizCompleted) {
                QuizCompletedView(gameManagerVM: gameManagerVM)
            } else {
                VStack {
                    // Text
                    ReusableText(text: "Medical Study Quiz!", size: 30)
                    //         .padding()
                    
                    QuestionText(text: gameManagerVM.model.quizModel.question, size: 17)
                        .lineLimit(6)
                        .frame(width: UIScreen.main.bounds.size.width - 40, height: UIScreen.main.bounds.size.height/5, alignment: .center)
                        .multilineTextAlignment(.center)
                    
                    Spacer()
                    
                    
                    
                    ZStack {
                        // Circle background colour
                        Circle()
                            .stroke(lineWidth: 15)
                            .foregroundColor(.gray)
                            .opacity(0.3)
                        
                        
                        // Circle foreground the moves with the timer
                        Circle()
                            .trim(from: 0.0, to: min(CGFloat((Double(gameManagerVM.progress) * Double(gameManagerVM.maxProgress))/100),1.0))
                            .stroke(LinearGradient(colors: [.orange, .red],
                                                   startPoint: .topLeading,
                                                   endPoint: .bottomTrailing),
                                    style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                            .rotationEffect(Angle(degrees: 270))
                            .animation(Animation.linear(duration: Double(gameManagerVM.maxProgress)), value: gameManagerVM.progress)
                        
                        ReusableText(text: String(gameManagerVM.progress), size: 30)
                    }.frame(width: 150, height: 150)
                    
                    
                    Spacer()
                    
                    OptionsGridView(gameManagerVM: gameManagerVM)
                }
            }
        }.onAppear{
            self.gameManagerVM.start()
            
        }
        .onDisappear{
            self.gameManagerVM.reset()
        }.navigationBarBackButtonHidden(true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
