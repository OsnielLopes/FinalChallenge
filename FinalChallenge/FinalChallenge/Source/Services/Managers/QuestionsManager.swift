//
//  QuestionsManager.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 15/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class QuestionsManager {
    static func insert() {
        
        
        AuthorDAO.shared.create(authorName: Project.Localizable.Question.author) { (author, error) -> (Void) in
            
            for question in Project.Localizable.Question.allCases {
                
                CategoryDAO.shared.create(name: question.category) { (category, error) -> (Void) in
                    
                        DissertativeQuestionDAO.shared.create(questionText: question.localized, category: category!, author: author!, completion: { (_, _) -> (Void) in })
                }
            }
            
            
        }
        
    }
    
    static func generateQuestionsForToday(){
        DissertativeQuestionDAO.shared.fetchAll { (questions, error) -> (Void) in
            guard error == nil && questions != nil else{
                fatalError("Impossible fetch the dissertative questions from the CoreDate")
            }
            
            var todayQuestions: [DissertationQuestion] = Array()
            
            if var unansweredQuestions = questions?.filter({ (question) -> Bool in
                return question.answers?.count == 0
            }) {
            
                
                if unansweredQuestions.count < 3 {
                    let alreadyAnsweredQuestions = questions?.filter({ (question) -> Bool in
                        return !unansweredQuestions.contains(question)
                    })
                    
                    todayQuestions.append(contentsOf: unansweredQuestions)
                    while todayQuestions.count < 3 {
                        
                        let random = alreadyAnsweredQuestions!.randomElement()
                        
                        if !(todayQuestions.contains(random!)) {
                            todayQuestions.append(random!)
                        }
                    }
                } else {
                    while todayQuestions.count < 3 {
                        
                        let random = unansweredQuestions.randomElement()
                        
                        if !(todayQuestions.contains(random!)) {
                            todayQuestions.append(random!)
                        }
                        
                        
                    }
                }
            }
            
            let questionsDescriptions: [String] = todayQuestions.map({ (question) -> String in
                return question.questionText!
            })
            
            UserDefaults.standard.set(questionsDescriptions, forKey: "todayQuestions")
            
        }
    }
}
