//
//  AnswerQuestionPresenter.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 05/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

enum QuestionType {
    case dissertative
    case radiobox
    case checkbox
}

class AnswerQuestionPresenter: NSObject, AnswerQuestionPresenterInputProtocol, AnswerQuestionInteractorOutputProtocol {

    // MARK: - Properties
    private var question: Question?
    private var type: QuestionType = QuestionType.dissertative
    
	// MARK: - Viper Module Properties
    weak var view: AnswerQuestionPresenterOutputProtocol!
    var interactor: AnswerQuestionInteractorInputProtocol!
    var router: AnswerQuestionRouterProtocol!

    // MARK: - AnswerQuestionPresenterInputProtocol
    func loadCurrentQuestion() {
        self.interactor.fetchCurrentQuestion()
    }
    
    func didTouchBackButton() {
        self.router.presentDailyQuestion()
    }
    
    func didTouchSaveButton(with answer: [String]) {
        self.interactor.saveAnswer(type: self.type, with: answer)
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func questionType() -> QuestionType {
        return self.type
    }
    
    func item(at indexPath: Int) -> String {
        if let radioQuestion = self.question as? RadioboxQuestion {
            return radioQuestion.options?[indexPath] ?? ""
        } else if let checkQuestion = self.question as? CheckboxQuestion {
            return checkQuestion.options?[indexPath] ?? ""
        } else {
//            return Project.Localizable.Placeholder.answerTextArea.localized
            return ""
        }
    }
    
    func didSelectItem(at indexPath: Int) {
        //FIXME: create functions to radio and checkbox (?)
    }
    
    func currentAnswer() -> Answer? {
        return self.question?.answers?.first(where: { (answer) -> Bool in
            let aAnswer = answer as! Answer
            return Calendar.current.isDateInToday(aAnswer.date! as Date)
        }) as? Answer
    }
    
    // MARK: - AnswerQuestionPresenterInteractorOutputProtocol
    func handleFetchSuccess(with result: Question) {
        self.question = result
        self.view.showLoading(false)
        self.view.showQuestion(with: result.questionText ?? "")
        
        if self.question is DissertationQuestion {
            self.type = QuestionType.dissertative
        } else if self.question is RadioboxQuestion {
            self.type = QuestionType.radiobox
        } else {
            self.type = QuestionType.checkbox
        }
        self.view.reloadData()
    }
    
    func handleSaveSuccess() {
        self.router.presentDailyQuestion()
    }
    
    func handleFailure(with message: String) {
        self.view.showError(with: message)
    }
    
    // MARK: - Private Methods

}
