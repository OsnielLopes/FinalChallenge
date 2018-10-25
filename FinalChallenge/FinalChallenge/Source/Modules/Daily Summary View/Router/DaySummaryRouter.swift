//
//  DaySummaryRouter.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 24/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import UIKit

class DaySummaryRouter: NSObject, DaySummaryRouterProtocol {
    
    // MARK: - Constants
    private let storyBoardName = "DailyQuestion"
    private let viewIdentifier = "DailyQuestionView"
    
    // MARK: - Viper Module Properties
    weak var view: DailySummaryViewController!
    
    // MARK: - Constructors
    override init() {
        super.init()
        
        let view = self.viewControllerFromStoryboard()
        let interactor = DaySummaryInteractor()
        let presenter = DaySummaryPresenter()
        
        presenter.interactor = interactor
        presenter.router = self
//        presenter.view = view
        
//        view.presenter = presenter
        interactor.output = presenter
        
        self.view = view
    }
    
    // MARK: - DailyQuestionRouterProtocol
    func present(with viewController: UIViewController) {
        viewController.present(self.view, animated: true, completion: nil)
    }
    
    func presentAsRoot(window: UIWindow) {
        let navigation = UINavigationController(rootViewController: self.view)
        window.rootViewController = navigation
    }
    
    func presentCalendar() {
        //FIXME: create implementation to present calendar Router
    }
    
    func presentAnswerQuestion() {
        //FIXME: create implementation to present answer question Router
    }
    
    // MARK: - Private methods
    private func viewControllerFromStoryboard() -> DailySummaryViewController {
        let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)
        
        return viewController as! DailyQuestionView
    }
    
}
