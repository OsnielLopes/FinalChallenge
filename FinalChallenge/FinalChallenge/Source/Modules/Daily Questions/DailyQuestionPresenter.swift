////
////  DailyQuestionPresenter.swift
////  FinalChallenge
////
////  Created Ana Carolina Silva on 04/10/18.
////  Copyright © 2018. All rights reserved.
////
//
//import UIKit
//
//class DailyQuestionPresenter: NSObject, DailyQuestionPresenterInputProtocol, DailyQuestionInteractorOutputProtocol {
//    // MARK: - Viper Module Properties
//
//    weak var view: DailyQuestionPresenterOutputProtocol!
//    var interactor: DailyQuestionInteractorInputProtocol!
//    var router: DailyQuestionRouterProtocol!
//
//    // MARK: - DailyQuestionPresenterInputProtocol
//    var numberOfCards: Int = 5
//    
//    func showDailyQuestions() {
//        self.interactor.fetchDailyQuestions()
//    }
//    
//    func didSelectQuestion(at indexPath: IndexPath) {
//        
//    }
//    
//    func didTouchButtonReturn() {
//        
//    }
//    
//    func didTouchButtonRemove() {
//        
//    }
//    
//    // MARK: - DailyQuestionPresenterInteractorOutputProtocol
//    func dailyQuestionsFetched() {
//        
//    }
//    
//    func dailyQuestionsFailed() {
//        
//    }
//    
//    // MARK: - Private Methods
//
//}
