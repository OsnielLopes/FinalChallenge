//
//  DailyQuestionPresenter.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionPresenter: NSObject, DailyQuestionPresenterInputProtocol, DailyQuestionInteractorOutputProtocol {

	// MARK: - Viper Module Properties
    weak var view: DailyQuestionPresenterOutputProtocol!
    var interactor: DailyQuestionInteractorInputProtocol!
    var router: DailyQuestionRouterProtocol!

    // MARK: - DailyQuestionPresenterInputProtocol
    func numberOfSections() -> Int {
        //FIXME: return the number of sections that will be presented
        return 1
    }
    
    func numberOfCards(in section: Int) -> Int {
        //FIXME: return the number of cards that will be presented
        return 3
    }
    
    func loadDailyQuestions() {
        //FIXME:
    }
    
    func item(at indexPath: Int) -> Question {
        //FIXME:
        return Question()
    }
    
    func didSelectItem(at indexPath: Int) {
        //FIXME:
    }
    
    func loadNewQuestion() {
        //FIXME:
    }
    
    func removeQuestion(at indexPath: Int) {
        //FIXME:
    }

    // MARK: - DailyQuestionPresenterInteractorOutputProtocol
    func handleSuccess(with results: [Question]) {
        //FIXME:
    }
    
    func handleFailure(with message: String) {
        //FIXME:
    }
    
	// MARK: - Private Methods

}
