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
    }

    // MARK: - OnboardingPresenterOutputProtocol

	// MARK: - Private Methods

}

extension OnboardingView: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
    
}
