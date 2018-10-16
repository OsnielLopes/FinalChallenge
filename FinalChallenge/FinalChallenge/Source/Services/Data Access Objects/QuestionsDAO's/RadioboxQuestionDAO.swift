//
//  RadioboxQuestionDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import CoreData

class RadioboxQuestionDAO {
    
    static let shared = RadioboxQuestionDAO()
    
    private init() { }
    
    func fetchAll(completion: @escaping ([RadioboxQuestion]?, DataAccessError?) -> (Void)) {
        if let allQuestions = CoreDataManager.shared.fetch(RadioboxQuestion.self) {
            completion(allQuestions, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all RadioboxQuestion"))
        }
    }
    
    func create(questionText: String, category: Category, author: Author, options: [String], completion: @escaping (RadioboxQuestion?, DataAccessError?) -> (Void)) {
        if let newQuestion = CoreDataManager.shared.create(type: RadioboxQuestion.self) {
            
            newQuestion.questionText = questionText
            newQuestion.category = category
            newQuestion.questionAuthor = author
            newQuestion.options = options
            
            completion(newQuestion, nil)
            
            CoreDataManager.shared.saveContext()
            
        }
    }
    
    func update(question: RadioboxQuestion, questionText: String? = nil, category: Category? = nil, author: Author? = nil, options: [String]? = nil, completion: @escaping (RadioboxQuestion?, DataAccessError?) -> (Void)) {
        
        if let updatedQuestionText = questionText {
            question.questionText = updatedQuestionText
        }
        if let updatedQuestionCategory = category {
            question.category?.removeFromQuestions(question)
            updatedQuestionCategory.addToQuestions(question)
            question.category = updatedQuestionCategory
        }
        if let updatedAuthor = author {
            question.questionAuthor?.removeFromCreatedQuestions(question)
            updatedAuthor.addToCreatedQuestions(question)
            question.questionAuthor = updatedAuthor
        }
        if let updatedOptions = options {
            question.options = updatedOptions
        }
        
        CoreDataManager.shared.saveContext()
        
        completion(question, nil)
        
    }
    
}
