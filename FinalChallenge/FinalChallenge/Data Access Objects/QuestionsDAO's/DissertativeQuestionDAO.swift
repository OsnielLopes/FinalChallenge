//
//  DissertativeQuestionDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 05/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class DissertativeQuestionDAO {
    
    static let shared = DissertativeQuestionDAO()
    
    private init() { }
    
    func fetchAll(completion: @escaping ([DissertationQuestion]?, DataAccessError?) -> (Void)) {
        if let allQuestions = CoreDataManager.shared.fetch(DissertationQuestion.self) {
            completion(allQuestions, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all DissertationQuestion"))
        }
    }
    
    func create(questionText: String, category: Category, author: Author, completion: @escaping (DissertationQuestion?, DataAccessError?) -> (Void)) {
        if let newQuestion = CoreDataManager.shared.create(type: DissertationQuestion.self) {
            
            newQuestion.questionText = questionText
            newQuestion.category = category
            newQuestion.questionAuthor = author
            
            completion(newQuestion, nil)
            
            CoreDataManager.shared.saveContext()
            
        }
    }
    
    func update(question: DissertationQuestion, questionText: String? = nil, category: Category? = nil, author: Author? = nil, completion: @escaping (DissertationQuestion?, DataAccessError?) -> (Void)) {
        
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
        
        CoreDataManager.shared.saveContext()
        
        completion(question, nil)
    }
    
}
