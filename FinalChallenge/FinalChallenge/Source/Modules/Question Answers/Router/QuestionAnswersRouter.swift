//
//  QuestionAnswersRouter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 01/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit
import Hero

class QuestionAnswersRouter: NSObject, QuestionAnswersRouterProtocol {

	// MARK: - Constants
	private let storyBoardName = "QuestionAnswers"
	private let viewIdentifier = "QuestionAnswersView"

	// MARK: - Viper Module Properties
	weak var view: QuestionAnswersView!

	// MARK: - Constructors
    init(question: Question) {
		super.init()

		let view = self.viewControllerFromStoryboard()
        let interactor = QuestionAnswersInteractor(question: question)
        let presenter = QuestionAnswersPresenter(question: question)

		presenter.interactor = interactor
		presenter.router = self
		presenter.view = view

		view.presenter = presenter
		interactor.output = presenter

		self.view = view
	}

    // MARK: - QuestionAnswersRouterProtocol
    func present(with viewController: UIViewController) {
        viewController.present(self.view, animated: true, completion: nil)
    }
    
    func dismiss() {
        self.view.dismiss(animated: true)
    }

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> QuestionAnswersView {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

		return viewController as! QuestionAnswersView
	}
}
