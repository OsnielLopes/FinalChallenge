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
        if let allQuestions = CoreDataManager.shared.fetch(Question.self) {
            completion(allQuestions, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all Question"))
        }
    }
    
    func delete(question: Question, completion: @escaping (DataAccessError?) -> (Void)) {
        CoreDataManager.shared.delete(question)
        completion(nil)
    }
    
}
