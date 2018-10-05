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
        if let questions = CoreDataManager.shared.fetch(DissertationQuestion.fetchRequest()) as? [DissertationQuestion] {
            completion(questions, nil)
        } else {
            completion(nil, DataAccessError(message: "There was a problem fetching all questions."))
        }
    }
    
    func create(questionText: String, category: Category, author: Author, completion: @escaping (Question?, DataAccessError?) -> (Void)) {
        
        if let newQuestion = CoreDataManager.shared.create(object: DissertationQuestion.self) {
            
            newQuestion.questionText = questionText
            newQuestion.category = category
            newQuestion.questionAuthor = author
            
            CoreDataManager.shared.saveContext()
            
        }
        completion(nil, DataAccessError(message: "Error when creating new question"))
        
    }
    
    func update(question: DissertationQuestion, questionText: String? = nil, category: Category? = nil, author: Author? = nil, completion: @escaping (Question?, DataAccessError?) -> (Void)) {
        
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
