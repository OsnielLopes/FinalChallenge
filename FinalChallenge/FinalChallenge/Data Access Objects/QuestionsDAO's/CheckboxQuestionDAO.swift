//
//  CheckboxQuestionDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 05/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class CheckboxQuestionDAO {
    
    static let shared = CheckboxQuestionDAO()
    
    private init() { }
    
    func fetchAll(completion: @escaping ([CheckboxQuestion]?, DataAccessError?) -> (Void)) {
        if let allQuestions = CoreDataManager.shared.fetch(CheckboxQuestion.fetchRequest()) as? [CheckboxQuestion] {
            completion(allQuestions, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all CheckboxQuestion"))
        }
    }
    
    func create(questionText: String, category: Category, author: Author, options: [String], completion: @escaping (CheckboxQuestion?, DataAccessError?) -> (Void)) {
        if let newQuestion = CoreDataManager.shared.create(type: CheckboxQuestion.self) as? CheckboxQuestion {
            
            newQuestion.questionText = questionText
            newQuestion.category = category
            newQuestion.questionAuthor = author
            newQuestion.options = options
            
            completion(newQuestion, nil)
            
            CoreDataManager.shared.saveContext()
            
        }
    }
    
    func update(question: CheckboxQuestion, questionText: String? = nil, category: Category? = nil, author: Author? = nil, options: [String]? = nil, completion: @escaping (CheckboxQuestion?, DataAccessError?) -> (Void)) {
        
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
    
    func delete(question: CheckboxQuestion, completion: @escaping (DataAccessError?) -> (Void)) {
        CoreDataManager.shared.delete(question)
        completion(nil)
    }
    
}
