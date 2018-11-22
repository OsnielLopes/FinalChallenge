//
//  ProfileRouter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 07/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class ProfileRouter: NSObject, ProfileRouterProtocol {

	// MARK: - Constants
	private let storyBoardName = "Profile"
	private let viewIdentifier = "ProfileView"

	// MARK: - Viper Module Properties
	weak var view: ProfileView!

	// MARK: - Constructors
	override init() {
		super.init()

		let view = self.viewControllerFromStoryboard()
		let interactor = ProfileInteractor()
		let presenter = ProfilePresenter()

		presenter.interactor = interactor
		presenter.router = self
		presenter.view = view

		view.presenter = presenter
		interactor.output = presenter

		self.view = view
	}

    // MARK: - ProfileRouterProtocol

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> ProfileView {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

		return viewController as! ProfileView
	}
}
