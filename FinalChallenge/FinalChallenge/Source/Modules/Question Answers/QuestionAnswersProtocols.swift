//
//  QuestionAnswersProtocols.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 01/11/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Router
protocol QuestionAnswersRouterProtocol: class {
    func present(with viewController: UIViewController)
    func dismiss()
}

// MARK: - Interactor
protocol QuestionAnswersInteractorInputProtocol {
    func fetchAnswers()
}

// MARK: - Presenter
protocol QuestionAnswersPresenterInputProtocol: class {
    func fetchQuestion() -> Question
    func fetchAnswers()
    func didTapToDismiss()
    
    func numberOfRows() -> Int
    func numberOfSections(in section: Int) -> Int
    func item(at indexPath: Int) -> Any
}

protocol QuestionAnswersInteractorOutputProtocol: class {
    func handleSuccess(with results: [Answer])
    func handleFailure(with message: String)
}

// MARK: - View
protocol QuestionAnswersPresenterOutputProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(message: String)
    func reloadData()
}
