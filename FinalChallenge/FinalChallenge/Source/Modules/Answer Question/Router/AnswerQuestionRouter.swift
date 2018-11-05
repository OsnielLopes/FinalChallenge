//
//  AnswerQuestionRouter.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 05/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class AnswerQuestionRouter: NSObject, AnswerQuestionRouterProtocol {

	// MARK: - Constants
	private let storyBoardName = "AnswerQuestion"
	private let viewIdentifier = "AnswerQuestionView"

	// MARK: - Viper Module Properties
	weak var view: AnswerQuestionView!

	// MARK: - Constructors
    init(question: Question) {
		super.init()

		let view = self.viewControllerFromStoryboard()
		let interactor = AnswerQuestionInteractor(question)
		let presenter = AnswerQuestionPresenter()

		presenter.interactor = interactor
		presenter.router = self
		presenter.view = view

		view.presenter = presenter
		interactor.output = presenter

		self.view = view
	}

    // MARK: - AnswerQuestionRouterProtocol
    func presentDailyQuestion() {
        
    }
    
    
    func present(with viewController: UIViewController) {
        
    }
    
    func presentAsRoot(window: UIWindow) {
        let navigation = UINavigationController(rootViewController: self.view)
        window.rootViewController = navigation
    }
    
    // MARK: - Private methods
	private func viewControllerFromStoryboard() -> AnswerQuestionView {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

		return viewController as! AnswerQuestionView
	}
}
