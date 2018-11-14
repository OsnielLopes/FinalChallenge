//
//  StatisticsFactory.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 14/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class StatisticsFactory {
    
    static let shared = StatisticsFactory()
    
    private init() {}
    
    func generateStatistics(completion: @escaping (StatisticsDTO?, [DataAccessError]?) -> ()) {
        var user: User!
        var daysInARow: Int!
        var questionsAnswered: Int!
        var moodsInputed: Int!
        var errors: [DataAccessError] = []

        var didFinishFetchingUser = false
        var didFinishFetchingDaysInARow = false
        var didFinishFetchingQuestionsAnswered = false
        var didFinishFetchingMoodsInputed = false
        
        let finish = {
            if didFinishFetchingUser && didFinishFetchingDaysInARow && didFinishFetchingQuestionsAnswered && didFinishFetchingMoodsInputed {
                completion(StatisticsDTO(user: user, daysInARow: daysInARow, questionsAnswered: questionsAnswered, moodsInputed: moodsInputed), nil)
            }
        }
        
        UserDAO.shared.fetch(completion: { fetchedUser, err in
            guard let fetchedUser = fetchedUser, err == nil else {
                errors.append(err!)
                return
            }
            user = fetchedUser
        })
        
    }
    
}
