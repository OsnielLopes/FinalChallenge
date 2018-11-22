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
    func firstView() -> OnboardingPageView?
    
    func askPermissionForHealthKit()
    func askPermissionForCameraUsage()
    
    func didFinishOnboarding()
}

// MARK: - Interactor
protocol OnboardingInteractorInputProtocol {
    func saveUser(withName name: String, withAvatar avatar: UIImage, andCover cover: UIImage)
}

// MARK: - Presenter
protocol OnboardingPresenterInputProtocol: class {
    func page(before view: OnboardingPageView) -> OnboardingPageView?
    func page(after view: OnboardingPageView) -> OnboardingPageView?
    
    func setUserAvatar(_ image: UIImage)
    func setUserCover(_ image: UIImage)
    func setUserName(_ name: String)
    
    func didFinishOnboarding()
}

protocol OnboardingInteractorOutputProtocol: class {
//    func handleSuccessSavedUser(with result: User)
    func handleFailure(with message: String)
}

// MARK: - View
protocol OnboardingPresenterOutputProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(_ message: String)
}
