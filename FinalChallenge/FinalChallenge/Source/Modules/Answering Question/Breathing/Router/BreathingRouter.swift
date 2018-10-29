//
//  BreathingRouter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 26/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class BreathingRouter: NSObject, BreathingRouterProtocol {

	// MARK: - Constants
	private let storyBoardName = "Breathing"
	private let viewIdentifier = "BreathingView"

	// MARK: - Viper Module Properties
	weak var view: BreathingViewController!
    var daySummaryRouter: DaySummaryRouterProtocol!

	// MARK: - Constructors
    init(daySummaryRouter: DaySummaryRouterProtocol) {
        super.init()

		let view = self.viewControllerFromStoryboard()
		let presenter = BreathingPresenter()

        presenter.router = self
		view.presenter = presenter
		
		self.view = view
        
        self.daySummaryRouter = daySummaryRouter
	}

    // MARK: - BreathingRouterProtocol
    func present(with viewController: UIViewController) {
        viewController.present(self.view, animated: true, completion: nil)
    }
    
    func presentDailyQuestionsView() {
        let router = DailyQuestionRouter(daySummaryRouter: self.daySummaryRouter)
        router.present(with: self.view)
    }

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> BreathingViewController {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

		return viewController as! BreathingViewController
	}
}
