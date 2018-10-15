////
////  DailyQuestionRouter.swift
////  FinalChallenge
////
////  Created Ana Carolina Silva on 04/10/18.
////  Copyright © 2018. All rights reserved.
////
//
//import UIKit
//
//class DailyQuestionRouter: NSObject, DailyQuestionRouterProtocol {
//
//    // MARK: - Constants
//    private let storyBoardName = "DailyQuestion"
//    private let viewIdentifier = "DailyQuestionView"
//
//    // MARK: - Viper Module Properties
//    weak var view: DailyQuestionView!
//
//    // MARK: - Constructors
//    override init() {
//        super.init()
//
//        let view = self.viewControllerFromStoryboard()
//        let interactor = DailyQuestionInteractor()
//        let presenter = DailyQuestionPresenter()
//
//        presenter.interactor = interactor
//        presenter.router = self
//        presenter.view = view
//
//        view.presenter = presenter
//        interactor.output = presenter
//
//        self.view = view
//    }
//
//    // MARK: - DailyQuestionRouterProtocol
//
//    // MARK: - Private methods
//    private func viewControllerFromStoryboard() -> DailyQuestionView {
//        let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
//        let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)
//
//        return viewController as! DailyQuestionView
//    }
//
//}
