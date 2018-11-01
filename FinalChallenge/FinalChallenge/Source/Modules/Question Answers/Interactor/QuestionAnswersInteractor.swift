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
    }

    // MARK: - Private Methods

}
