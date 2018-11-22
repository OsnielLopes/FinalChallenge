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

        var didFinishFetchingUserSucc = false
        var didFinishFetchingAnswersSucc = false
        var didFinishFetchingMoodsInputedSucc = false
        
        let finishedWithSuccess = {
            if didFinishFetchingUserSucc && didFinishFetchingAnswersSucc && didFinishFetchingMoodsInputedSucc {
                completion(StatisticsDTO(user: user, daysInARow: daysInARow, questionsAnswered: questionsAnswered, moodsInputed: moodsInputed), nil)
            }
        }
        
        let finishedWithFailure = {
            completion(nil, errors)
        }
        
        UserDAO.shared.fetch(completion: { fetchedUser, err in
            guard let fUser = fetchedUser, err == nil else {
                errors.append(err!)
                finishedWithFailure()
                return
            }
            didFinishFetchingUserSucc = true
            user = fUser
            finishedWithSuccess()
        })
        
        AnswerDAO.shared.fetchAll(completion: { fetchedAnswers, err in
            guard var fetchedAnswers = fetchedAnswers, err == nil else {
                errors.append(err!)
                finishedWithFailure()
                return
            }
            didFinishFetchingAnswersSucc = true

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
            finishedWithSuccess()
        })
        
        MoodDAO.shared.fetchAll(completion: { fetchedMoodInputs, err in
            guard let fetchedMoodInputs = fetchedMoodInputs, err == nil else {
                errors.append(err!)
                finishedWithFailure()
                return
            }
            didFinishFetchingMoodsInputedSucc = true

            moodsInputed = fetchedMoodInputs.count
            finishedWithSuccess()
        })
        
    }
    
}
