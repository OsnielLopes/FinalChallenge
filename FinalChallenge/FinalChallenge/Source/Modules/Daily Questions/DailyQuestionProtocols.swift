//
//  DailyQuestionProtocols.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

// MARK: - Router
protocol DailyQuestionRouterProtocol: class {
    func present(with viewController: UIViewController)
    func presentAsRoot(window: UIWindow)
    
    func presentCalendar()
    func presentAnswerQuestion()
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

}
