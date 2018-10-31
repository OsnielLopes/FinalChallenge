//
//  QuestionsHistoricRouter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 31/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class QuestionsHistoricRouter: NSObject, QuestionsHistoricRouterProtocol {
    

	// MARK: - Constants
	private let storyBoardName = "QuestionsHistoric"
	private let viewIdentifier = "QuestionsHistoricView"

	// MARK: - Viper Module Properties
	weak var view: QuestionsHistoricView!

	// MARK: - Constructors
	override init() {
		super.init()

		let view = self.viewControllerFromStoryboard()
		let interactor = QuestionsHistoricInteractor()
		let presenter = QuestionsHistoricPresenter()

		presenter.interactor = interactor
		presenter.router = self
		presenter.view = view

		view.presenter = presenter
		interactor.output = presenter

		self.view = view
	}

    // MARK: - QuestionsHistoricRouterProtocol
    
    func presentQuestionView(_ question: Question) {
        fatalError()
    }

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> QuestionsHistoricView {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

		return viewController as! QuestionsHistoricView
	}
}
