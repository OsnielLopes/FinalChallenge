//
//  Question.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 04/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import CoreData

class QuestionDAO: QuestionDAOHelper{
    
    static let shared = QuestionDAO()
        
    private override init() {}
    
    func fetchAll(completion: @escaping ([Question]?, DataAccessError?) -> (Void)) {
        self.fetchAllInternal(completion: completion)
    }
    
    func delete(question: Question, completion: @escaping (Question?, DataAccessError?) -> (Void)) {
        self.deleteInternal(question: question, completion: completion)
    }
    
}
