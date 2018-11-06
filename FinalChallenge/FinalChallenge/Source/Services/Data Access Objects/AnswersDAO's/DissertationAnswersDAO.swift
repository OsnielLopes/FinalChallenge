//
//  DissertationAnswersDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class DissertationAnswersDAO {
    
    static let shared = DissertationAnswersDAO()
    
    private init() { }
    
    func fetchAll(completion: @escaping ([DissertationAnswer]?, DataAccessError?) -> (Void)) {
        if let allAnswers = CoreDataManager.shared.fetch(DissertationAnswer.self) {
            completion(allAnswers, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all DissertationAnswer"))
        }
        
    }
    
    func create(question: DissertationQuestion, text: String, date: Date, completion: @escaping (DissertationAnswer?, DataAccessError?) -> (Void)) {
        if let newAnswer = CoreDataManager.shared.create(type: DissertationAnswer.self) {
            
            newAnswer.text = text
            newAnswer.question = question
            newAnswer.date = date as NSDate
            question.addToAnswers(newAnswer)
            
            CoreDataManager.shared.saveContext()
            completion(newAnswer, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when creating new answer"))
        }
    }
    
    func update(answer: DissertationAnswer, text: String? = nil, question: DissertationQuestion? = nil, completion: @escaping (DissertationAnswer?, DataAccessError?) -> (Void)) {
        
        if let updatedText = text, let updatedQuestion = question {
            answer.text = updatedText
            answer.question?.removeFromAnswers(answer)
            answer.question = updatedQuestion
            updatedQuestion.addToAnswers(answer)
            
            CoreDataManager.shared.saveContext()
            completion(answer, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when updating new answer"))
        }
    }
    
}
