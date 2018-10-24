//
//  DaySummaryProtocols.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 24/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Router
protocol DaySummaryRouterProtocol: class {
    func present(with viewController: UIViewController)
    func presentAsRoot(window: UIWindow)
    
    func presentCalendar()
    func presentAnswerQuestion()
}

// MARK: - Interactor
protocol DaySummaryInteractorInputProtocol {
    func fetchQuestionsForToday()
    func fetchNewQuestion()
}

// MARK: - Presenter
protocol DaySummaryPresenterInputProtocol: class {
    func numberOfSections() -> Int
    func numberOfCards(in section: Int) -> Int
    
    func loadDailyQuestions()
    
    func item(at indexPath: Int) -> Question
    func didSelectItem(at indexPath: Int)
    
    func didTouchBackButton()
    func loadNewQuestion()
    func removeQuestion(at indexPath: Int)
}

protocol DaySummaryInteractorOutputProtocol: class {
    func handleSuccess(with results: [Question])
    func handleFailure(with message: String)
}

// MARK: - View
protocol DaySummaryPresenterOutputProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(message: String)
    func reloadData()
}
