//
//  DailyQuestionPresenter.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionPresenter: NSObject, DailyQuestionPresenterInputProtocol, DailyQuestionInteractorOutputProtocol {

	// MARK: - Viper Module Properties
    weak var view: DailyQuestionPresenterOutputProtocol!
    var interactor: DailyQuestionInteractorInputProtocol!
    var router: DailyQuestionRouterProtocol!

    // MARK: - DailyQuestionPresenterInputProtocol

    // MARK: - DailyQuestionPresenterInteractorOutputProtocol

	// MARK: - Private Methods

}
