//
//  AnswerQuestionProtocols.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 05/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

// MARK: - Router
protocol AnswerQuestionRouterProtocol: class {
    func present(with viewController: UIViewController)
    
    func presentDailyQuestion()
}

// MARK: - Interactor
protocol AnswerQuestionInteractorInputProtocol {
    func saveAnswer(type: QuestionType, with answers: [String])
    func fetchCurrentQuestion()
}

// MARK: - Presenter
protocol AnswerQuestionPresenterInputProtocol: class {
    func loadCurrentQuestion()
    
    func didTouchBackButton()
    func didTouchSaveButton(with answer: [String])
    
    func numberOfSections() -> Int
    func questionType() -> QuestionType
    
    func item(at indexPath: Int) -> String
    func didSelectItem(at indexPath: Int)
    
    func currentAnswer() -> Answer?
}

protocol AnswerQuestionInteractorOutputProtocol: class {
    func handleFetchSuccess(with result: Question)
    func handleSaveSuccess()
    func handleFailure(with message: String)
}

// MARK: - View
protocol AnswerQuestionPresenterOutputProtocol: class {
    func showLoading(_ loading: Bool)
    
    func showQuestion(with title: String)
    func showError(with message: String)
    
    func reloadData()
}
