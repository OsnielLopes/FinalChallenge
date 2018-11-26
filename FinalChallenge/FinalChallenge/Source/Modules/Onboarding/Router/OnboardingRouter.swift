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
    
    // MARK: - Pages
    private var pages: [OnboardingPageView] = []

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
        
        self.pages = []
        for i in 1...7 {
            self.pages.append(self.pageFromStoryboard(with: "Onboarding\(i)thView"))
        }
        
        
	}

    // MARK: - OnboardingRouterProtocol
    func page(before view: OnboardingPageView) -> OnboardingPageView? {
        let currentIndex = self.pages.firstIndex(of: view)!
        return currentIndex - 1 < 0 ? nil : self.pages[currentIndex - 1]
    }
    
    func page(after view: OnboardingPageView) -> OnboardingPageView? {
        let currentIndex = self.pages.firstIndex(of: view)!
        return currentIndex + 1 >= self.pages.count ? nil : self.pages[currentIndex + 1]
    }
    
    func firstView() -> OnboardingPageView {
        return self.pages[0]
    }
    
    func askPermissionForHealthKit(with completion: @escaping () -> (Bool)) {
    }
    
    func askPermissionForCameraRollUsage(with completion: @escaping () -> (Bool)) {
    }
    
    func presentAsRoot(window: UIWindow) {
        window.rootViewController = self.view
    }

    func didFinishOnboarding() {
        self.view.dismiss(animated: true, completion: nil)
        MainRouter().present(with: self.view)
    }

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> OnboardingView {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

		return viewController as! OnboardingView
	}
    
    private func pageFromStoryboard(with identifier: String) -> OnboardingPageView {
        let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: identifier) as! OnboardingPageView
        
        viewController.pageViewController = self.view

        return viewController
    }
}
