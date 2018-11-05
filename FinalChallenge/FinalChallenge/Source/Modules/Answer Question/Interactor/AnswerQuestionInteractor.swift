//
//  AnswerQuestionInteractor.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 05/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class AnswerQuestionInteractor: NSObject, AnswerQuestionInteractorInputProtocol {

    // MARK: - Properties
    private var question: Question
    
    // MARK: - Viper Module Properties
    weak var output: AnswerQuestionInteractorOutputProtocol!

    // MARK: - Interactor initialiazer
    required init(_ question: Question) {
        self.question = question
    }
    
	// MARK: - AnswerQuestionInteractorInputProtocol
    func saveAnswer(type: QuestionType, with answers: [String]) {
        
        switch type {
        case .dissertative:
            guard let dissertativeQuestion = question as? DissertationQuestion else { return }
            
            DissertationAnswersDAO.shared.create(question: dissertativeQuestion, text: answers[0], date: Date()) { (answer, error) -> (Void) in
                if answer != nil {
                    self.output.handleSaveSuccess()
                }
            }
        case .checkbox:
            break
        case .radiobox:
            break
        }
        
        
    }
    
    func fetchCurrentQuestion() {
        self.output.handleFetchSuccess(with: self.question)
    }
    
    // MARK: - Private Methods
    
}
