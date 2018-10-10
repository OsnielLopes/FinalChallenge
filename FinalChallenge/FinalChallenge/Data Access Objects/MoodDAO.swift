//
//  MoodDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class MoodDAO {
    
    static let shared = MoodDAO()
    
    private init() { }
    
    private func initializeMoodTypes() {
        self.createMoodType(text: "Happy", icon: "happy.png", completion: { type, err in
            if err != nil {
                print("Error when creating happy mood type")
            }
        })
        
        self.createMoodType(text: "Sad", icon: "sad.png", completion: { type, err in
            if err != nil {
                print("Error when creating happy mood type")
            }
        })
    }
    
    private func createMoodType(text: String, icon: String, completion: @escaping (MoodType?, DataAccessError?) -> (Void)) {
        if let newMoodType = CoreDataManager.shared.create(type: MoodType.self) {
            newMoodType.typeIcon = icon
            newMoodType.typeText = text
            CoreDataManager.shared.saveContext()
        } else {
            completion(nil, DataAccessError(message: "Error when creating mood type"))
        }
    }
    
    func fetchMoodTypes(completion: @escaping ([MoodType]?, DataAccessError?) -> (Void)) {
        if let allMoodTypes = CoreDataManager.shared.fetch(MoodType.self) {
            completion(allMoodTypes, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all mood types"))
        }
    }
    
    func insertMood(moodType: MoodType, date: Date, completion: @escaping (MoodInput?, DataAccessError?) -> (Void)) {
        if let newMoodInput = CoreDataManager.shared.create(type: MoodInput.self) {
            newMoodInput.date = date as NSDate
            newMoodInput.moodType = moodType
            moodType.addToInsertedMoods(newMoodInput)
            CoreDataManager.shared.saveContext()
            
            completion(newMoodInput, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when inserting mood"))
        }
    }
    
}
