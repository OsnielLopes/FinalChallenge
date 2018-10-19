//
//  DailyQuestionInteractor.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionInteractor: NSObject, DailyQuestionInteractorInputProtocol {

    // MARK: - Properties
    private var questions: [Question] = []
    
	// MARK: - Viper Module Properties
    weak var output: DailyQuestionInteractorOutputProtocol!

	// MARK: - DailyQuestionInteractorInputProtocol
    func fetchQuestionsForToday() {
        
        
        //FIXME: get questions on CoreData
    }
    
    func fetchNewQuestion() {
        //FIXME: get new question on CoreData that was not yet get
    }
    
    // MARK: - Private Methods

}
