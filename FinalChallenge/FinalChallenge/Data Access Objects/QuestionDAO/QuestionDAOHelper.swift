//
//  QuestionDAOProtocol.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 05/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class QuestionDAOHelper {
    
    internal func fetchAllInternal<T: Question>(completion: @escaping ([T]?, DataAccessError?) -> (Void)) {
        if let questions = CoreDataManager.shared.fetch(Question.fetchRequest()) as? [T] {
            completion(questions, nil)
        } else {
            completion(nil, DataAccessError(message: "There was a problem fetching all \(T.self)"))
        }
    }
    
    internal func createInternal<T: Question>(questionType: T.Type, questionText: String, category: Category, author: Author, completion: @escaping (T?, DataAccessError?) -> (Void)) {
        if let newQuestion = CoreDataManager.shared.create(object: T.self) {
            
            newQuestion.questionText = questionText
            newQuestion.category = category
            newQuestion.questionAuthor = author
            
            completion(newQuestion, nil)
            
            CoreDataManager.shared.saveContext()
            
        }
        completion(nil, DataAccessError(message: "Error when creating new \(T.self)."))
    }
    
    internal func updateInternal<T: Question>(question: T, questionText: String? = nil, category: Category? = nil, author: Author? = nil, completion: @escaping (T?, DataAccessError?) -> (Void)) {
        
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
    
    internal func deleteInternal<T: Question>(question: T, completion: @escaping (T?, DataAccessError?) -> (Void)) {
        question.category?.removeFromQuestions(question)
        CoreDataManager.shared.persistentContainer.viewContext.delete(question)
        CoreDataManager.shared.saveContext()
    }
    
}
