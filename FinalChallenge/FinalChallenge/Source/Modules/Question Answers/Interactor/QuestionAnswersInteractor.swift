//
//  QuestionAnswersInteractor.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 01/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class QuestionAnswersInteractor: NSObject, QuestionAnswersInteractorInputProtocol {

	// MARK: - Viper Module Properties
    weak var output: QuestionAnswersInteractorOutputProtocol!
    
    // MARK: - Properties
    var question: Question
    var answers: [Answer] = []
    
    // MARK: - Constructors
    init(question: Question) {
        self.question = question
    }

	// MARK: - QuestionAnswersInteractorInputProtocol
    func fetchAnswers() {
        AnswerDAO.shared.fetchByQuestion(question, completion: { answers, err in
            guard let answers = answers, err == nil else { 
                self.output.handleFailure(with: "There was a problem fetching the answers for this date")
                return
            }
            self.answers = answers
            self.output.handleSuccess(with: self.answers)
        })
    }

    // MARK: - Private Methods

}
