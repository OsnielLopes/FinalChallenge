//
//  Question.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 04/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import CoreData

class QuestionDAO {
    
    static let shared = QuestionDAO()
    
    private init() {}
    
    func fetchAll(completion: @escaping ([Question]?, DataAccessError?) -> (Void)) {
        do {
            if let questions = try CoreDataManager.shared.persistentContainer.viewContext.fetch(Question.fetchRequest()) as? [Question] {
                completion(questions, nil)
            }
        } catch {
            completion(nil, DataAccessError(message: "There was a problem fetching all questions."))
        }
        
    }
    
    func create(questionText: String, category: Category, author: Author, completion: @escaping (Question?, DataAccessError?) -> (Void)) {
        
        if let newQuestion = NSEntityDescription.insertNewObject(forEntityName: "Question", into: CoreDataManager.shared.persistentContainer.viewContext) as? Question {
            
            newQuestion.questionText = questionText
            newQuestion.category = category
            newQuestion.questionAuthor = author
            
            CoreDataManager.shared.saveContext()
            
        }
        completion(nil, DataAccessError(message: "Error when creating new question"))
        
    }
    
    func update(question: Question, questionText: String? = nil, category: Category? = nil, author: Author? = nil, completion: @escaping (Question?, DataAccessError?) -> (Void)) {
        
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
        
        
    }
    
    func destroy(object: NSManagedObject, completion: @escaping (NSManagedObject?, DataAccessError?) -> (Void)) {
        
    }
    
    
    
}
