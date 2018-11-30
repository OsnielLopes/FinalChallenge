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

    // MARK: - Properties
    var question: Question
    var answers: [Answer] = [] {
        didSet {
            print(answers)
        }
    }
    
    // MARK: - Constructors
    init(question: Question) {
        self.question = question
    }
    
    // MARK: - QuestionAnswersPresenterInputProtocol
    
    func fetchQuestion() -> Question {
        return self.question
    }
    
    func fetchAnswers() {
        self.interactor.fetchAnswers()
    }
    
    func didTapToDismiss() {
        self.router.dismiss()
    }
    
    func numberOfRows() -> Int {
        return self.answers.count + 1
    }
    
    func numberOfSections(in section: Int) -> Int {
        return 1
    }
    
    func item(at indexPath: Int) -> Any {
        return indexPath == 0 ? self.question : self.answers[indexPath - 1]
    }

    // MARK: - QuestionAnswersPresenterInteractorOutputProtocol
    func handleSuccess(with results: [Answer]) {
        self.answers = results
        self.view.showLoading(false)
        self.view.reloadData()
    }
    
    func handleFailure(with message: String) {
        self.view.showLoading(false)
        self.view.showError(message: message)
        self.view.reloadData()
    }

	// MARK: - Private Methods
    func sortAnswers() {
        self.answers.sort(by: { ($0.date! as Date) < ($1.date! as Date) })
    }

}
