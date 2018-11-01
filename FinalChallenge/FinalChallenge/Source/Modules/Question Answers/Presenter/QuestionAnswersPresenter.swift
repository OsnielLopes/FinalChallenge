//
//  QuestionAnswersPresenter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 01/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class QuestionAnswersPresenter: NSObject, QuestionAnswersPresenterInputProtocol, QuestionAnswersInteractorOutputProtocol {

	// MARK: - Viper Module Properties
    weak var view: QuestionAnswersPresenterOutputProtocol!
    var interactor: QuestionAnswersInteractorInputProtocol!
    var router: QuestionAnswersRouterProtocol!

    // MARK: - QuestionAnswersPresenterInputProtocol

    // MARK: - QuestionAnswersPresenterInteractorOutputProtocol

	// MARK: - Private Methods

}
