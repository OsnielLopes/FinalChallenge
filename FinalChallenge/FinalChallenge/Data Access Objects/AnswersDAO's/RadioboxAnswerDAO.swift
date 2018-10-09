//
//  RadioboxAnswerDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class RadioboxAnswersDAO {
    
    static let shared = RadioboxAnswersDAO()
    
    private init() { }
    
    func fetchAll(completion: @escaping ([RadioboxAnswer]?, DataAccessError?) -> (Void)) {
        if let allAnswers = CoreDataManager.shared.fetch(RadioboxAnswer.self) {
            completion(allAnswers, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all CheckboxAnswer"))
        }
        
    }
    
    func create(question: RadioboxQuestion, date: Date, option: Int, completion: @escaping (RadioboxAnswer?, DataAccessError?) -> (Void)) {
        if let newAnswer = CoreDataManager.shared.create(type: RadioboxAnswer.self) {
            
            if question.options!.count <= option {
                completion(nil, DataAccessError(message: "Option is greater than the number of avaiable options"))
                return
            }
            
            newAnswer.option = Int32(option)
            newAnswer.question = question
            newAnswer.date = date as NSDate
            question.addToAnswers(newAnswer)
            
            CoreDataManager.shared.saveContext()
            completion(newAnswer, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when creating new answer"))
        }
    }
    
    func update(answer: RadioboxAnswer, option: Int? = nil, date: Date? = nil, question: CheckboxQuestion? = nil, completion: @escaping (RadioboxAnswer?, DataAccessError?) -> (Void)) {
        
        if let updatedQuestion = question {
            answer.question?.removeFromAnswers(answer)
            answer.question = updatedQuestion
            updatedQuestion.addToAnswers(answer)
        }
        
        if let updatedOption  = option {
            if let updatedQuestion = question, updatedQuestion.options!.count <= updatedOption {
                completion(nil, DataAccessError(message: "Option is greater than the number of avaiable options"))
                return
            }
            answer.option = Int32(updatedOption)
        }
        
        if let updatedDate = date {
            answer.date = updatedDate as NSDate
        }
        
        CoreDataManager.shared.saveContext()
        
    }
    
    
}
