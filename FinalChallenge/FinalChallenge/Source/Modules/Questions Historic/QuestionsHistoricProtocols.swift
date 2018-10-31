//
//  QuestionsHistoricProtocols.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 31/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation

// MARK: - Router
protocol QuestionsHistoricRouterProtocol: class {
    func presentQuestionView(_ question: Question)
}

// MARK: - Interactor
protocol QuestionsHistoricInteractorInputProtocol {
    func fetchQuestions()
}

// MARK: - Presenter
protocol QuestionsHistoricPresenterInputProtocol: class {
    func fetchQuestions()
    func moveToQuestion(_ question: Question)
    
    func numberOfSections() -> Int
    func numberOfQuestions(in section: Int) -> Int
    func item(at indexPath: IndexPath) -> Question
    func header(at section: Int) -> Category

}

protocol QuestionsHistoricInteractorOutputProtocol: class {
    func handleSuccessFetchedQuestion(with results: [Question])
    func handleFailureFetchedQuestion(with message: String)
}

// MARK: - View
protocol QuestionsHistoricPresenterOutputProtocol: class {
    func showLoading(_ loading: Bool)
    func showError(message: String)
    func didFetchQuestions()
}
