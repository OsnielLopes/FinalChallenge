//
//  DailyQuestionProtocols.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 04/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

// MARK: - Router
protocol DailyQuestionRouterProtocol: class {

}

// MARK: - Interactor
protocol DailyQuestionInteractorInputProtocol {
    //Here is all the functions that we will use to access data services!
    func fetchDailyQuestions()
}

// MARK: - Presenter
protocol DailyQuestionPresenterInputProtocol: class {
    //Here is the functions and variables that view will need to present information and actions
    var numberOfCards: Int { get }
    
    func showDailyQuestions()
    func didSelectQuestion(at indexPath: IndexPath)
    func didTouchButtonReturn()
    func didTouchButtonRemove()
}

protocol DailyQuestionInteractorOutputProtocol: class {
    func dailyQuestionsFetched(questions: [Question])
    func dailyQuestionsFailed()
}

// MARK: - View
protocol DailyQuestionPresenterOutputProtocol: class {
    //var with properties that will be presented on viewController
    //Example:
    //    var enteredName: String? { get }
    //    var enteredEmail: String? { get }
    //    var enteredPhone: String? { get }
    //    var enteredAddress: String? { get }
}
