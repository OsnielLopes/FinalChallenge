//
//  ProfilePresenter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 07/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class ProfilePresenter: NSObject, ProfilePresenterInputProtocol, ProfileInteractorOutputProtocol {

	// MARK: - Viper Module Properties
    weak var view: ProfilePresenterOutputProtocol!
    var interactor: ProfileInteractorInputProtocol!
    var router: ProfileRouterProtocol!

    // MARK: - ProfilePresenterInputProtocol

    // MARK: - ProfilePresenterInteractorOutputProtocol
    func handleSuccessFetchedMood(with results: [MoodInput]) {
    }
    
    func handleFailureFetchedMood(with message: String) {
    }

	// MARK: - Private Methods

}
