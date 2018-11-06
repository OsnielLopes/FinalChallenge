//
//  BreathingProtocols.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 26/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Router
protocol BreathingRouterProtocol: class {
    func present(with viewController: UIViewController)
    func presentDailyQuestionsView()
}

// MARK: - Interactor

// MARK: - Presenter
protocol BreathingPresenterInputProtocol: class {
    
    func didTapViewToContinue()

}

// MARK: - View
