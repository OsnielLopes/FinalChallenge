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
        if let questions = CoreDataManager.shared.fetch(Question.fetchRequest()) as? [Question] {
            completion(questions, nil)
        } else {
            completion(nil, DataAccessError(message: "There was a problem fetching all questions."))
        }
    }
    
    func delete(question: Question, completion: @escaping (NSManagedObject?, DataAccessError?) -> (Void)) {
        question.category?.removeFromQuestions(question)
        CoreDataManager.shared.persistentContainer.viewContext.delete(question)
        CoreDataManager.shared.saveContext()
    }
    
}
