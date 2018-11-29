//
//  OnboardingProtocols.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 21/11/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Router
protocol OnboardingRouterProtocol: class {
    func page(before view: OnboardingPageView) -> OnboardingPageView?
    func page(after view: OnboardingPageView) -> OnboardingPageView?
    func firstView() -> OnboardingPageView
    func userView() -> Onboarding7thView
    func presentAsRoot(window: UIWindow)
    
    func didFinishOnboarding()
}

// MARK: - Interactor
protocol OnboardingInteractorInputProtocol {
    func createUserIfNecessary()
    func setUserAvatar(_ image: UIImage)
    func setUserCover(_ image: UIImage)
    func setUserName(_ name: String)
}

// MARK: - Presenter
protocol OnboardingPresenterInputProtocol: class {
    func page(before view: UIViewController) -> OnboardingPageView?
    func page(after view: UIViewController) -> OnboardingPageView?
    func firstView() -> OnboardingPageView
    func userView() -> Onboarding7thView
    
    func createUserIfNecessary()
    func setUserAvatar(_ image: UIImage)
    func setUserCover(_ image: UIImage)
    func setUserName(_ name: String)

    func didFinishOnboarding()
}

protocol OnboardingInteractorOutputProtocol: class {
    
    func handleSuccessUpdatedUser(with result: User)
    func handleFailureUpdatedUser(with message: String)

    func handleSuccessCreatedUser(with result: User)
    func handleFailureCreatedUser(with message: String)

}

// MARK: - View
protocol OnboardingPresenterOutputProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(_ message: String)
    
    func didFetchUser(_ user: User)
    func didUpdateUser(_ user: User)
}
