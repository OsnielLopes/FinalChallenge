//
//  DailyQuestionInteractor.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 16/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailyQuestionInteractor: NSObject, DailyQuestionInteractorInputProtocol {

    // MARK: - Properties
    private var questions: [Question] = []
    
	// MARK: - Viper Module Properties
    weak var output: DailyQuestionInteractorOutputProtocol!

	// MARK: - DailyQuestionInteractorInputProtocol
    func fetchQuestionsForToday() {
        var todayQuestions: [Question] = []
        
        // If questions were set for today, then just get questions from userDefalts and return to interactor
        if let date = UserDefaults.standard.object(forKey: Project.UserSettings.appHasBeenUsedToday.rawValue) as? Date, Calendar.current.compare(date, to: Date(), toGranularity: Calendar.Component.day) == .orderedSame, let todayQuestionsText = UserDefaults.standard.stringArray(forKey: Project.UserSettings.todayQuestions.rawValue) {
            
            QuestionDAO.shared.fetchAll { (questions, error) -> (Void) in
                guard let aQuestions = questions, error == nil else {
                    self.output.handleFailure(with: "Impossible to load questions for today")
                    return
                }
                
                for text in todayQuestionsText {
                    guard let question = aQuestions.first(where: { return $0.questionText == text }) else { return }
                    todayQuestions.append(question)
                }
                
                self.questions = todayQuestions
                self.output.handleSuccess(with: todayQuestions)
            }
            
        } else {
            QuestionsManager.shared.createQuestionsForToday { (questions, error) -> (Void) in
                guard let aQuestions = questions, error == nil else {
                    self.output.handleFailure(with: "Impossible to load questions for today")
                    return
                }
                
                UserDefaults.standard.set(Date(), forKey: Project.UserSettings.appHasBeenUsedToday.rawValue)
                
                self.questions = aQuestions
                self.output.handleSuccess(with: aQuestions)
                
                
            }
        }
    }
    
    func fetchNewQuestion() {
        //FIXME: get new question on CoreData that was not yet get
    }
    
    // MARK: - Private Methods

}
