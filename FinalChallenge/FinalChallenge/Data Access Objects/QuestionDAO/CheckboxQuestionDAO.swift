//
//  CheckboxQuestionDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 05/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class CheckboxQuestionDAO: QuestionDAOHelper {
    
    static let shared = CheckboxQuestionDAO()
    
    private override init() { }
    
    func fetchAll(completion: @escaping ([CheckboxQuestion]?, DataAccessError?) -> (Void)) {
        self.fetchAllInternal(completion: completion)
    }
    
    func create(questionText: String, category: Category, author: Author, options: [String], completion: @escaping (CheckboxQuestion?, DataAccessError?) -> (Void)) {
        self.createInternal(questionType: CheckboxQuestion.self, questionText: questionText, category: category, author: author, completion: { question, error in
            guard let checkboxQuestion = question else {
                completion(nil, DataAccessError(message: "Error when creating checkbox question"))
                return
            }
            checkboxQuestion.options = options
            CoreDataManager.shared.saveContext()
            completion(checkboxQuestion, nil)
        })
    }
    
    func update(question: CheckboxQuestion, questionText: String? = nil, category: Category? = nil, author: Author? = nil, options: [String]? = nil, completion: @escaping (CheckboxQuestion?, DataAccessError?) -> (Void)) {
        self.updateInternal(question: question, questionText: questionText, category: category, author: author, completion: { question, error in
            
            guard let checkboxQuestion = question else {
                completion(nil, DataAccessError(message: "Error when updating checkbox question"))
                return
            }
            
            if let options = options {
                checkboxQuestion.options = options
            }
            
            completion(checkboxQuestion, nil)
            
        })
    }
    
}
