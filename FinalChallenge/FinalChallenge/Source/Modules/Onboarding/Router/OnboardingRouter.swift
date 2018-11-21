//
//  OnboardingRouter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 21/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class OnboardingRouter: NSObject, OnboardingRouterProtocol {

	// MARK: - Constants
	private let storyBoardName = "Onboarding"
	private let viewIdentifier = "OnboardingView"

	// MARK: - Viper Module Properties
	weak var view: OnboardingView!

	// MARK: - Constructors
	override init() {
		super.init()

		let view = self.viewControllerFromStoryboard()
		let interactor = OnboardingInteractor()
		let presenter = OnboardingPresenter()

		presenter.interactor = interactor
		presenter.router = self
		presenter.view = view

		view.presenter = presenter
		interactor.output = presenter

		self.view = view
	}

    // MARK: - OnboardingRouterProtocol

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> OnboardingView {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

		return viewController as! OnboardingView
	}
}
