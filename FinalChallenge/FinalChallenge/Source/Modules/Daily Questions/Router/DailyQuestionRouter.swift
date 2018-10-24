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

	// MARK: - Constructors
	override init() {
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
        //FIXME: create implementation to present calendar Router
    }
    
    func presentAnswerQuestion() {
        //FIXME: create implementation to present answer question Router
    }

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> DailyQuestionView {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

		return viewController as! DailyQuestionView
	}
}
