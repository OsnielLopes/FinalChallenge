//
//  DailyQuestionInteractor.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionInteractor: NSObject, DailyQuestionInteractorInputProtocol {

	// MARK: - Viper Module Properties
    weak var output: DailyQuestionInteractorOutputProtocol!

	// MARK: - DailyQuestionInteractorInputProtocol
    func fetchQuestionsForToday() {
        //FIXME: get questions on CoreData
    }
    
    // MARK: - Private Methods

}
