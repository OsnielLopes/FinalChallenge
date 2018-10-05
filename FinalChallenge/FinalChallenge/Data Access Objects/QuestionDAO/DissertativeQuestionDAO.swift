//
//  DissertativeQuestionDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 05/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class DissertativeQuestionDAO: QuestionDAOHelper {
    
    static let shared = DissertativeQuestionDAO()
    
    private override init() { }
    
    func fetchAll(completion: @escaping ([DissertationQuestion]?, DataAccessError?) -> (Void)) {
        self.fetchAllInternal(completion: completion)
    }
    
    func create(questionText: String, category: Category, author: Author, completion: @escaping (DissertationQuestion?, DataAccessError?) -> (Void)) {
        self.createInternal(questionType: DissertationQuestion.self, questionText: questionText, category: category, author: author, completion: completion)
    }
    
    func update(question: DissertationQuestion, questionText: String? = nil, category: Category? = nil, author: Author? = nil, completion: @escaping (DissertationQuestion?, DataAccessError?) -> (Void)) {
        self.updateInternal(question: question, questionText: questionText, category: category, author: author, completion: completion)
    }
    
}
