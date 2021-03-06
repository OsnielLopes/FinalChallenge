//
//  MainRouter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 29/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class MainRouter: NSObject, MainRouterProtocol {

	// MARK: - Constants
	private let storyBoardName = "Main"
	private let viewIdentifier = "MainView"

	// MARK: - Viper Module Properties
	weak var view: MainView!

	// MARK: - Constructors
	override init() {
		super.init()

		let view = self.viewControllerFromStoryboard()
		let presenter = MainPresenter()

		presenter.router = self
		presenter.view = view

		view.presenter = presenter

		self.view = view
	}

    // MARK: - MainRouterProtocol
    func presentAsRoot(window: UIWindow) {
        window.rootViewController = self.view
    }

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> MainView {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier) as! MainView
        
        viewController.viewControllers = self.generateTabBarViewControllers()

		return viewController
	}
    
    private func generateTabBarViewControllers() -> [UIViewController] {
        var viewControllers: [UIViewController] = []
        
        let daySummaryViewRouter = DaySummaryRouter()
        daySummaryViewRouter.view.tabBarItem = UITabBarItem(title: "Calendar", image: UIImage(named: "Calendar Icon Deselected"), selectedImage: UIImage(named: "Calendar Icon Selected"))
        viewControllers.append(daySummaryViewRouter.view)
        
        let questionsHistoricRouter = QuestionsHistoricRouter()
        questionsHistoricRouter.view.tabBarItem = UITabBarItem(title: "Questions", image: UIImage(named: "Question Icon Deselected"), selectedImage: UIImage(named: "Question Icon Selected"))
        viewControllers.append(UINavigationController(rootViewController: questionsHistoricRouter.view))
        
        return viewControllers
    }
}
