// GameMangerVM.swift
// GameManagerVM code functions for the quiz
// Created by James Berry on 10/11/2022.


import Foundation
import SwiftUI

class GameManagerVM : ObservableObject {

    static var currentIndex = 0
    
    static func createGameModel(i:Int) -> Quiz {
        return Quiz(currentQuestionIndex: i, quizModel: quizData[i])
    }
    
    @Published var model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
    @Published var testIndex = GameManagerVM.currentIndex //NEW
    
    // Timer
    var timer = Timer()
    var maxProgress = 60
    @Published var progress = 0
    
    init() {

    }
    
    deinit {
        self.reset()
        
    }
    
    // Checks if the anwsers are correct and the clicked anwser is the correct one
    func verifyAnswer(selectedOption: QuizOption) {
        for index in model.quizModel.optionsList.indices {
            model.quizModel.optionsList[index].isMatched = false
            model.quizModel.optionsList[index].isSelected = false
            
        }
        if let index = model.quizModel.optionsList.firstIndex(where: {$0.optionId == selectedOption.optionId}) {
            if selectedOption.optionId ==  model.quizModel.answer {
                model.quizModel.optionsList[index].isMatched = true
                model.quizModel.optionsList[index].isSelected = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
                    guard let self else {return}
                    if (GameManagerVM.currentIndex < 9) {
                        GameManagerVM.currentIndex = GameManagerVM.currentIndex + 1
                        self.testIndex = GameManagerVM.currentIndex //NEW
                        self.model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
                    } else {
                        self.model.quizCompleted = true
                        self.model.quizWinningStatus = true
                        self.reset()
                    }
                }
            } else {
                model.quizModel.optionsList[index].isMatched = false
                model.quizModel.optionsList[index].isSelected = true
            }

        }
    }
    
    // Resets the quiz
    func restartGame() {
        GameManagerVM.currentIndex = 0
        model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
        self.start()
    }
    
    // Starts the quiz
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats:true, block: { [weak self] time in
            guard let self else {return}
            if self.progress == self.maxProgress {
                self.model.quizCompleted = true
                self.model.quizWinningStatus = false
                self.reset()
            } else {
                self.progress += 1
            }
        })
    }
     // Resets timer
    func reset () {
        timer.invalidate()
        self.progress = 0
    }
    
                                     
                                     
                                     
                                

}

// Questions
extension GameManagerVM
{
    static var quizData: [QuizModel] {
        [
            QuizModel(question: "A 23 year old man has a tremor in his right hand. Which of the following is the appropriate pharmacotherapy?",
                      answer: "A",
                      optionsList: [QuizOption(id: 11, optionId: "A", option: "Penicillamine", color: Color.yellow),
                                    QuizOption(id: 12,optionId: "B", option: "Propranolol", color: Color.red),
                                    QuizOption(id: 13,optionId: "C", option: "Deferoxamine", color: Color.green),
                                    QuizOption(id: 14,optionId: "D", option: "Prednisone", color: Color.purple)]),
            
            QuizModel(question: "A 78 year old man has progressive hearing loss in both ears and struggles understanding conversations in crowded places. Which is the likely diagnosis?",
                      answer: "C",
                      optionsList: [QuizOption(id: 21,optionId: "A", option: "Ototoxicity", color: Color.yellow),
                                    QuizOption(id: 22,optionId: "B", option: "Otosclerosis", color: Color.red),
                                    QuizOption(id: 23,optionId: "C", option: "Presbycusis", color: Color.green),
                                    QuizOption(id: 24,optionId: "D", option: "Cholesteatoma", color: Color.purple)]),
            
            QuizModel(question: "A 24 year old woman has random episodes of facial pain on the left cheek for about 30 seconds before subsiding. What is the next step in management?",
                      answer: "B",
                      optionsList: [QuizOption(id: 31,optionId: "A", option: "Amitriptyline", color: Color.yellow),
                                    QuizOption(id: 32,optionId: "B", option: "Carbamazepine", color: Color.red),
                                    QuizOption(id: 33,optionId: "C", option: "Microvascular Decompression", color: Color.green),
                                    QuizOption(id: 34,optionId: "D", option: "Radiofrequency Rhizotomy", color: Color.purple)]),
            
            QuizModel(question: "A 82 year old women lives on her own, does daily living activities her self. She makes one error when performing serial sevens. What is the likely symptom?",
                      answer: "C",
                      optionsList: [QuizOption(id: 41,optionId: "A", option: "Pseudodementia", color: Color.yellow),
                                    QuizOption(id: 42,optionId: "B", option: "Vascular Dementia", color: Color.red),
                                    QuizOption(id: 43,optionId: "C", option: "Ageing", color: Color.green),
                                    QuizOption(id: 44,optionId: "D", option: "Alzheimer Disease", color: Color.purple)]),
            QuizModel(question: "A 72 year old man has Alzheimer dementia. He can't count serial sevens and is already prescribed donepezil. Which is the best pharmacotherapy?",
                      answer: "D",
                      optionsList: [QuizOption(id: 51,optionId: "A", option: "Vitamin E", color: Color.yellow),
                                    QuizOption(id: 52,optionId: "B", option: "Ginkgo Biloba", color: Color.red),
                                    QuizOption(id: 53,optionId: "C", option: "Citalopram", color: Color.green),
                                    QuizOption(id: 54,optionId: "D", option: "Memantine", color: Color.purple)]),
            QuizModel(question: "A 67 year old man misplaces his belongings and gets really confused. He can only recall 1 of 3 objects shown to him. The symptoms are to do with?",
                      answer: "A",
                      optionsList: [QuizOption(id: 61,optionId: "A", option: "Hippocampus", color: Color.yellow),
                                    QuizOption(id: 62,optionId: "B", option: "Nucleus Accumbens", color: Color.red),
                                    QuizOption(id: 63,optionId: "C", option: "Substantia Nigra", color: Color.green),
                                    QuizOption(id: 64,optionId: "D", option: "Amygdala", color: Color.purple)]),
            QuizModel(question: "A 25 year old women had below-knee amputation of the left leg. She has epsiodes of shooting and burning pain in her left leg. What is needed for management?",
                      answer: "C",
                      optionsList: [QuizOption(id: 71,optionId: "A", option: "Ibuprofen Therapy", color: Color.yellow),
                                    QuizOption(id: 72,optionId: "B", option: "Oxycodone Therapy", color: Color.red),
                                    QuizOption(id: 73,optionId: "C", option: "Gabapentin Therapy", color: Color.green),
                                    QuizOption(id: 74,optionId: "D", option: "Surgical Revision", color: Color.purple)]),
            
            QuizModel(question: "A 63 year old man has blurry vison and issues walking. He has drooping of the upper eyelids and low lung volumes. What's the best drug mechanisms for this?",
                      answer: "C",
                      optionsList: [QuizOption(id: 81,optionId: "A", option: "Regeneration Of Acetylcholinesterase", color: Color.yellow),
                                    QuizOption(id: 82,optionId: "B", option: "Stimulation Of D2 Recptors", color: Color.red),
                                    QuizOption(id: 83,optionId: "C", option: "Inhibition Of Acetylcholinesterase", color: Color.green),
                                    QuizOption(id: 84,optionId: "D", option: "Stimulation of β2 Adrenergic Receptors", color: Color.purple)]),
            
            QuizModel(question: "A 64 year old women has dizziness. They last between 30-40 seconds. They happen after lying down or sitting up. Which is the likley diagnosis?",
                      answer: "D",
                      optionsList: [QuizOption(id: 91,optionId: "A", option: "Meniere Disease", color: Color.yellow),
                                    QuizOption(id: 92,optionId: "B", option: "Cerebral  Ischemia", color: Color.red),
                                    QuizOption(id: 93,optionId: "C", option: "Acoustic Neuroma", color: Color.green),
                                    QuizOption(id: 94,optionId: "D", option: "Benign Paroxysmal Positional Vertigo", color: Color.purple)]),
            
            QuizModel(question: "A 59 year old man with alcohol use disorder has forgetfulness and frequent falls. Neurologic examination shows horizontal nystagmus. Which supplement will prevent the condition?",
                      answer: "A",
                      optionsList: [QuizOption(id: 101,optionId: "A", option: "Vitamin B1", color: Color.yellow),
                                    QuizOption(id: 102,optionId: "B", option: "Vitamin B12", color: Color.red),
                                    QuizOption(id: 103,optionId: "C", option: "Vitamin B6", color: Color.green),
                                    QuizOption(id: 104,optionId: "D", option: "Vitamin B9", color: Color.purple)])

        ]
    }
}
