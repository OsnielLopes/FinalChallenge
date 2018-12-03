//
//  DailyQuestionRouter.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionRouter: NSObject, DailyQuestionRouterProtocol {
    
	// MARK: - Constants
	private let storyBoardName = "DailyQuestion"
	private let viewIdentifier = "DailyQuestionView"

	// MARK: - Viper Module Properties
	weak var view: DailyQuestionView!
    var daySummaryRouter: DaySummaryRouterProtocol!

	// MARK: - Constructors
	init(daySummaryRouter: DaySummaryRouterProtocol) {
		super.init()

		let view = self.viewControllerFromStoryboard()
		let interactor = DailyQuestionInteractor()
		let presenter = DailyQuestionPresenter()

		presenter.interactor = interactor
		presenter.router = self
		presenter.view = view

		view.presenter = presenter
		interactor.output = presenter

		self.view = view
        
        self.daySummaryRouter = daySummaryRouter
	}

    // MARK: - DailyQuestionRouterProtocol
    func present(with viewController: UIViewController) {
        viewController.present(self.view, animated: true, completion: nil)
    }
    
    func presentAsRoot(window: UIWindow) {
        let navigation = UINavigationController(rootViewController: self.view)
        window.rootViewController = navigation
    }
    
    func presentCalendar() {
        self.daySummaryRouter.dismiss()
    }
    
    func presentAnswerQuestion(question: Question) {
        let answerQuestionrouter = AnswerQuestionRouter(question: question)
        answerQuestionrouter.present(with: self.view)
        //FIXME: create implementation to present answer question Router
    }

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> DailyQuestionView {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

        (viewController as! DailyQuestionView).shouldReloadDailyQuestions = true
        
		return viewController as! DailyQuestionView
	}
    
}
