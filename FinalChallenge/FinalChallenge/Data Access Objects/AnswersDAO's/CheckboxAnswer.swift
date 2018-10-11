//
//  CheckboxAnswer.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class CheckboxAnswersDAO {
    
    static let shared = CheckboxAnswersDAO()
    
    private init() { }
    
    func fetchAll(completion: @escaping ([CheckboxAnswer]?, DataAccessError?) -> (Void)) {
        if let allAnswers = CoreDataManager.shared.fetch(CheckboxAnswer.self) {
            completion(allAnswers, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all CheckboxAnswer"))
        }
        
    }
    
    func create(question: CheckboxQuestion, options: [Int], completion: @escaping (CheckboxAnswer?, DataAccessError?) -> (Void)) {
        if let newAnswer = CoreDataManager.shared.create(type: CheckboxAnswer.self) {
        
            newAnswer.options = options
            newAnswer.question = question
            question.addToAnswers(newAnswer)
            
            CoreDataManager.shared.saveContext()
            completion(newAnswer, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when creating new answer"))
        }
    }
    
    func update(answer: CheckboxAnswer, options: [Int]? = nil, question: CheckboxQuestion? = nil, completion: @escaping (CheckboxAnswer?, DataAccessError?) -> (Void)) {
        
        if let updatedOption  = options {
            answer.options = updatedOption
        }
        
        if let updatedQuestion = question {
            answer.question?.removeFromAnswers(answer)
            answer.question = updatedQuestion
            updatedQuestion.addToAnswers(answer)
        }
        
        CoreDataManager.shared.saveContext()
        
    }
    
    
}
