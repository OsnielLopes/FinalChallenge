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
        var didFinishFetchingAnswers = false
        var didFinishFetchingMoodsInputed = false
        
        let finishedWithSuccess = {
            if didFinishFetchingUser && didFinishFetchingAnswers && didFinishFetchingMoodsInputed {
                completion(StatisticsDTO(user: user, daysInARow: daysInARow, questionsAnswered: questionsAnswered, moodsInputed: moodsInputed), nil)
            }
        }
        
        let finishedWithFailure = {
            if didFinishFetchingUser && didFinishFetchingAnswers && didFinishFetchingMoodsInputed {
                completion(nil, errors)
            }
        }
        
        UserDAO.shared.fetch(completion: { fetchedUser, err in
            didFinishFetchingUser = true
            guard let fetchedUser = fetchedUser, err == nil else {
                errors.append(err!)
                finishedWithFailure()
                return
            }
            user = fetchedUser
            finishedWithSuccess()
        })
        
        AnswerDAO.shared.fetchAll(completion: { fetchedAnswers, err in
            didFinishFetchingAnswers = true
            guard var fetchedAnswers = fetchedAnswers, err == nil else {
                errors.append(err!)
                finishedWithFailure()
                return
            }
            var answeredQuestions: [Question] = []
            fetchedAnswers.sort(by: { $0.date! as Date > $1.date! as Date })
            var days = 0
            for a in fetchedAnswers {
                let comparableDate = Calendar.current.date(byAdding: .day, value: -1 * days, to: Date())!
                if Calendar.current.isDate(a.date! as Date, inSameDayAs: comparableDate) {
                    days += 1
                } else {
                    break
                }
                if !answeredQuestions.contains(a.question!) {
                    answeredQuestions.append(a.question!)
                }
            }
            daysInARow = days
            questionsAnswered = answeredQuestions.count
        })
        
        MoodDAO.shared.fetchAll(completion: { fetchedMoodInputs, err in
            didFinishFetchingMoodsInputed = true
            guard let fetchedMoodInputs = fetchedMoodInputs, err == nil else {
                errors.append(err!)
                finishedWithFailure()
                return
            }
            moodsInputed = fetchedMoodInputs.count
            finishedWithSuccess()
        })
        
    }
    
}
