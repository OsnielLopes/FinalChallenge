//
//  OnboardingPresenter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 21/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class OnboardingPresenter: NSObject, OnboardingPresenterInputProtocol, OnboardingInteractorOutputProtocol {

	// MARK: - Viper Module Properties
    weak var view: OnboardingPresenterOutputProtocol!
    var interactor: OnboardingInteractorInputProtocol!
    var router: OnboardingRouterProtocol!

    // MARK: - OnboardingPresenterInputProtocol
    func page(before view: UIViewController) -> OnboardingPageView? {
        return self.router.page(before: view as! OnboardingPageView)
    }
    
    func page(after view: UIViewController) -> OnboardingPageView? {
        return self.router.page(after: view as! OnboardingPageView)
    }
    
    func didFinishOnboarding() {
        self.router.didFinishOnboarding()
    }
    
    func firstView() -> OnboardingPageView {
        return self.router.firstView()
    }

    // MARK: - OnboardingPresenterInteractorOutputProtocol

	// MARK: - Private Methods

}
