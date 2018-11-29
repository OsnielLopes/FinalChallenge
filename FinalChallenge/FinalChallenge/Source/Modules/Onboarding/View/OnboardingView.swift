//
//  OnboardingView.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 21/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class OnboardingView: UIPageViewController, OnboardingPresenterOutputProtocol {

	// MARK: - Viper Module Properties
	var presenter: OnboardingPresenterInputProtocol!

	// MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setViewControllers([self.presenter.firstView()], direction: .forward, animated: true, completion: nil)
        self.dataSource = self
        
        self.presenter.createUserIfNecessary()
    }

    // MARK: - OnboardingPresenterOutputProtocol
    
    func showLoading(_ loading: Bool) {
        // FIXME Implement loading on view
    }
    
    func showError(_ message: String) {
        // FIXME Implement error display on view
    }
    
    func didFetchUser(_ user: User) {
        self.presenter.userView().setUser(user)
    }
    
    func didUpdateUser(_ user: User) {
        self.presenter.userView().setUser(user)
    }
    
    // MARK: - Public Methods
    func didFinishOnBoarding() {
        self.presenter.didFinishOnboarding()
    }
    
    func didUpdateUsername(with name: String) {
        self.presenter.setUserName(name)
    }
    
    func didUpdateAvatar(_ image: UIImage) {
        self.presenter.setUserAvatar(image)
    }
    
    func didUpdateCover(_ image: UIImage) {
        self.presenter.setUserCover(image)
    }
    
	// MARK: - Private Methods

}

extension OnboardingView: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return self.presenter.page(before: viewController as! OnboardingPageView)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return self.presenter.page(after: viewController as! OnboardingPageView)
    }
    
}
