//
//  DailyQuestionInteractor.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 04/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionInteractor: NSObject, DailyQuestionInteractorInputProtocol {

	// MARK: - Viper Module Properties
    weak var output: DailyQuestionInteractorOutputProtocol!
    private var questionService = QuestionDAO.shared

	// MARK: - DailyQuestionInteractorInputProtocol
    func fetchDailyQuestions() {
        questionService.fetchAll { (questions, error) -> (Void) in
            if let aError = error {
                print(aError)
            } else {
//                self.output
            }
        }
    }
    
    // MARK: - Private Methods

}
