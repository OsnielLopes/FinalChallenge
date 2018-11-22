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
    func getTutorialPages() -> [OnboardingPageView] {
        return self.router.getPages()
    }

    // MARK: - OnboardingPresenterInteractorOutputProtocol

	// MARK: - Private Methods

}
