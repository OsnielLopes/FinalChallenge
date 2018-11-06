//
//  QuestionsHistoricInteractor.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 31/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class QuestionsHistoricInteractor: NSObject, QuestionsHistoricInteractorInputProtocol {
    
    // MARK: - Properties
    var questions: [Question] = []
    
	// MARK: - Viper Module Properties
    weak var output: QuestionsHistoricInteractorOutputProtocol!

	// MARK: - QuestionsHistoricInteractorInputProtocol
    
    func fetchQuestions() {
        QuestionDAO.shared.fetchAll(completion: { questions, err in
            guard let questions = questions, err == nil else {
                self.output.handleFailureFetchedQuestion(with: "There was a problem fetching the questions")
                return
            }
            self.questions = questions
            self.output.handleSuccessFetchedQuestion(with: self.questions)
        })
    }

    // MARK: - Private Methods

}
