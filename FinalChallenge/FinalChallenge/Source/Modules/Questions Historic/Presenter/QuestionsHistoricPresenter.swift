//
//  QuestionsHistoricPresenter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 31/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class QuestionsHistoricPresenter: NSObject, QuestionsHistoricPresenterInputProtocol, QuestionsHistoricInteractorOutputProtocol {

	// MARK: - Viper Module Properties
    weak var view: QuestionsHistoricPresenterOutputProtocol!
    var interactor: QuestionsHistoricInteractorInputProtocol!
    var router: QuestionsHistoricRouterProtocol!
    
    // MARK: - Properties
    var questions: [Question] = []
    var questionsCategoryVO: [QuestionsCategoryViewObject] = []

    // MARK: - QuestionsHistoricPresenterInputProtocol
    
    func fetchQuestions() {
        self.view.showLoading(true)
        self.interactor.fetchQuestions()
    }
    
    func numberOfSections() -> Int {
        return self.questionsCategoryVO.count
    }
    
    func numberOfQuestions(in section: Int) -> Int {
        return self.questionsCategoryVO[section].questions.count
    }
    
    func item(at indexPath: IndexPath) -> Question {
        return self.questionsCategoryVO[indexPath.section].questions[indexPath.row]
    }
    
    func header(at section: Int) -> Category {
        return self.questionsCategoryVO[section].category
    }
    
    func moveToQuestion(at indexPath: IndexPath) {
        self.router.presentQuestionView(self.questionsCategoryVO[indexPath.section].questions[indexPath.row])
    }
    

    // MARK: - QuestionsHistoricPresenterInteractorOutputProtocol
    
    func handleSuccessFetchedQuestion(with results: [Question]) {
        self.questions = results
        self.orderQuestions()
        self.view.showLoading(false)
        self.view.didFetchQuestions()
    }
    
    func handleFailureFetchedQuestion(with message: String) {
        self.view.showError(message: message)
        self.view.showLoading(false)
    }

	// MARK: - Private Methods
    
    private func orderQuestions() {
        let dictionary = Dictionary(grouping: self.questions, by: { $0.category! })
        dictionary.forEach({
            self.questionsCategoryVO.append(QuestionsCategoryViewObject(category: $0, questions: $1))
        })
    }

}
