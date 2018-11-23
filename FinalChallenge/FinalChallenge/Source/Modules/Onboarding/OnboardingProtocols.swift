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
    func presentAsRoot(window: UIWindow)

    
//    func askPermissionForHealthKit(with completion: @escaping () -> (Bool))
//    func askPermissionForCameraRollUsage(with completion: @escaping () -> (Bool))
    
    func didFinishOnboarding()
}

// MARK: - Interactor
protocol OnboardingInteractorInputProtocol {
//    func saveUser(withName name: String, withAvatar avatar: UIImage, andCover cover: UIImage)
}

// MARK: - Presenter
protocol OnboardingPresenterInputProtocol: class {
    func page(before view: UIViewController) -> OnboardingPageView?
    func page(after view: UIViewController) -> OnboardingPageView?
    func firstView() -> OnboardingPageView
    
//    func setUserAvatar(_ image: UIImage)
//    func setUserCover(_ image: UIImage)
//    func setUserName(_ name: String)

    func didFinishOnboarding()
}

protocol OnboardingInteractorOutputProtocol: class {
//    func handleSuccessSavedUser(with result: User)
//    func handleFailure(with message: String)
}

// MARK: - View
protocol OnboardingPresenterOutputProtocol: class {
//    func showLoading(_ loading: Bool)
//    func showError(_ message: String)
}
