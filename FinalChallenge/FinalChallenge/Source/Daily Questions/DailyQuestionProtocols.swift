//
//  DailyQuestionProtocols.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 04/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

// MARK: - Router

protocol DailyQuestionRouterProtocol: class {

}

// MARK: - Interactor

protocol DailyQuestionInteractorInputProtocol {

}

// MARK: - Presenter

protocol DailyQuestionPresenterInputProtocol: class {

}

protocol DailyQuestionInteractorOutputProtocol: class {

}

// MARK: - View

protocol DailyQuestionPresenterOutputProtocol: class {
    //var with properties that will be presented on viewController
    //Example:
    //    var enteredName: String? { get }
    //    var enteredEmail: String? { get }
    //    var enteredPhone: String? { get }
    //    var enteredAddress: String? { get }
}
