//
//  AnswerDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class AnswerDAO {
    
    static let shared = AnswerDAO()
    
    private init() {}
    
    func fetchAll(completion: @escaping ([Answer]?, DataAccessError?) -> (Void)) {
        if let allAnswers = CoreDataManager.shared.fetch(Answer.self) {
            completion(allAnswers, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all answers"))
        }
    }
    
    func delete(answer: Answer, completion: @escaping (DataAccessError?) -> (Void)) {
        CoreDataManager.shared.delete(answer)
        completion(nil)
    }
    
}
