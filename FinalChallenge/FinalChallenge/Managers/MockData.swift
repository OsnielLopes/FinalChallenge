//
//  MockData.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 15/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class MockData {
    
    static let shared = MockData()
    
    private init() {}
    
    func mockData() {
        if UserDefaults.standard.bool(forKey: "didMockData") {
            return
        }
        UserDefaults.standard.set(true, forKey: "didMockData")
        
        MoodDAO.shared.initializeMoodTypes()
        
        CategoryDAO.shared.create(name: "Familiares", completion: { cat, err in
            
            guard let cat = cat, err == nil else {
                UserDefaults.standard.set(false, forKey: "didMockData")
                return
            }
            
            AuthorDAO.shared.create(authorName: "System", completion: { (author, err) in
                
                guard let author = author, err == nil else {
                    UserDefaults.standard.set(false, forKey: "didMockData")
                    return
                }
                
                for _ in 0...5 {
                    DissertativeQuestionDAO.shared.create(questionText: "How are you?", category: cat, author: author, completion: { question, err in
                        
                        guard let question = question, err == nil else {
                            UserDefaults.standard.set(false, forKey: "didMockData")
                            return
                        }
                        
                        DissertationAnswersDAO.shared.create(question: question, text: "I'm fine", date: Date(), completion: { ans, err in
                            guard let _ = ans, err == nil else {
                                UserDefaults.standard.set(false, forKey: "didMockData")
                                return
                            }
                        })
                        
                    })
                }
                
                
            })
            
        })
        
        for type in MoodDAO.shared.moodTypes {
            MoodDAO.shared.insertMood(moodType: type, date: Date(), completion: { _, _ in })
        }
        
        
    }
    
}
