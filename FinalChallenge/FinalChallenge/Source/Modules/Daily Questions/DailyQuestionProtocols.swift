//
//  DailyQuestionProtocols.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

// MARK: - Router
protocol DailyQuestionRouterProtocol: class {
    func present(with viewController: UIViewController)
    func presentAsRoot(window: UIWindow)
    
    func presentCalendar()
    func presentAnswerQuestion()
}

// MARK: - Interactor
protocol DailyQuestionInteractorInputProtocol {
    func fetchQuestionsForToday()
    func fetchNewQuestion()
}

// MARK: - Presenter
protocol DailyQuestionPresenterInputProtocol: class {
    func numberOfSections() -> Int
    func numberOfCards(in section: Int) -> Int
    
    func loadDailyQuestions()
    
    func item(at indexPath: Int) -> Question
    func didSelectItem(at indexPath: Int)
    
    func didTouchBackButton()
    func loadNewQuestion()
    func removeQuestion(at indexPath: Int)
}

protocol DailyQuestionInteractorOutputProtocol: class {
    func handleSuccess(with results: [Question])
    func handleFailure(with message: String)
}

// MARK: - View
protocol DailyQuestionPresenterOutputProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(message: String)
    func reloadData()
}
