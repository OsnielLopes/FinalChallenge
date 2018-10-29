//
//  BreathingPresenter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 26/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class BreathingPresenter: NSObject, BreathingPresenterInputProtocol {

	// MARK: - Viper Module Properties
    var router: BreathingRouterProtocol!

    // MARK: - BreathingPresenterInputProtocol
    func didTapViewToContinue() {
        self.router.presentDailyQuestionsView()
    }

    // MARK: - BreathingPresenterInteractorOutputProtocol

	// MARK: - Private Methods

}
