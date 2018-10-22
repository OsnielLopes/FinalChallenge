//
//  QuestionsManager.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 15/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class QuestionsManager {
    
    static let shared = QuestionsManager()
    
    private init() { }
    
    func createAllQuestions() {
        AuthorDAO.shared.create(authorName: Project.Localizable.Question.author) { (author, error) -> (Void) in
            for question in Project.Localizable.Question.allCases {
                CategoryDAO.shared.create(name: Project.Localizable.Question.author, completion: { (category, error) -> (Void) in
                    
                    guard let aCategory = category, let aAuthor = author else {
                        fatalError("Error creating questions on CoreData")
                    }
                    
                    DissertativeQuestionDAO.shared.create(questionText: question.localized, category: aCategory, author: aAuthor, completion: { (_, _) -> (Void) in })
                })
            }
        }
    }
    
    func createQuestionsForToday(completion: @escaping ([Question]?, DataAccessError?) -> (Void)){
        QuestionDAO.shared.fetchAll { (questions, error) -> (Void) in
            guard let aQuestions = questions, error == nil else {
                completion(nil, error)
                fatalError("Impossible fetch the dissertative questions from the CoreDate")
            }
            
            var todayQuestions: [Question] = []
            
            let unansweredQuestions = aQuestions.filter({ return $0.answers?.count == 0 })
            
            if unansweredQuestions.count < 3 {
                todayQuestions.append(contentsOf: unansweredQuestions)
                todayQuestions.append(contentsOf: self.insertRandomQuestions(from: aQuestions, on: todayQuestions))
            } else {
                todayQuestions.append(contentsOf: self.insertRandomQuestions(from: unansweredQuestions, on: todayQuestions))
            }
            
            completion(todayQuestions, nil)
        }
    }
    
    // MARK: - Private functions
    private func insertRandomQuestions(from questionsA: [Question], on questionsB: [Question]) -> [Question] {
        var questionsToAdd = questionsB
        
        while questionsToAdd.count < 3 {
            let random = questionsA.randomElement()
            
            if !(questionsToAdd.contains(random!)) {
                questionsToAdd.append(random!)
            }
        }
        
        self.saveForToday(questions: questionsToAdd)
        
        return questionsToAdd
    }
    
    private func saveForToday(questions: [Question]) {
        let questionsDescriptions: [String] = questions.map({ return $0.questionText! })
        
        UserDefaults.standard.set(questionsDescriptions, forKey: Project.UserSettings.todayQuestions.rawValue)
    }
        
}
