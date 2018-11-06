//
//  DailyQuestionPresenter.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionPresenter: NSObject, DailyQuestionPresenterInputProtocol, DailyQuestionInteractorOutputProtocol {

    // MARK: - Properties
    private var questions: [Question] = []
    
	// MARK: - Viper Module Properties
    weak var view: DailyQuestionPresenterOutputProtocol!
    var interactor: DailyQuestionInteractorInputProtocol!
    var router: DailyQuestionRouterProtocol!

    // MARK: - DailyQuestionPresenterInputProtocol
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfCards(in section: Int) -> Int {
        return questions.count
    }
    
    func loadDailyQuestions() {
        self.view.showLoading(true)
        self.interactor.fetchQuestionsForToday()
    }
    
    func item(at indexPath: Int) -> Question {
        return questions[indexPath]
    }
    
    func didSelectItem(at indexPath: Int) {
        self.router.presentAnswerQuestion(question: questions[indexPath])
    }
    
    func didTouchBackButton() {
        self.router.presentCalendar()
    }
    
    func loadNewQuestion() {
        self.interactor.fetchNewQuestion()
    }
    
    func removeQuestion(at indexPath: Int) {
        self.questions.remove(at: indexPath)
        self.view.reloadData()
    }
    
    func currentAnswer(for question: Question) -> Answer? {
        return question.answers?.first(where: { (answer) -> Bool in
            let aAnswer = answer as! Answer
            return Calendar.current.isDateInToday(aAnswer.date! as Date)
        }) as? Answer
    }

    // MARK: - DailyQuestionPresenterInteractorOutputProtocol
    func handleSuccess(with results: [Question]) {
        self.questions = results
        self.view.showLoading(false)
        self.view.reloadData()
    }
    
    func handleFailure(with message: String) {
        self.view.showLoading(false)
        self.view.showError(message: message)
        self.view.reloadData()
    }
    
	// MARK: - Private Methods

}
