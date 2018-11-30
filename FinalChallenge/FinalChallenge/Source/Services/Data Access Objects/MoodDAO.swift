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
    
    var moodTypes: [MoodType] = []
    
    private init() {
        self.fetchMoodTypes(completion: { moodTypes, err in
            guard let moodTypes = moodTypes, err == nil else {
                self.initializeMoodTypes()
                return
            }
            
            if moodTypes.count == 0 {
                self.initializeMoodTypes()
            } else {
                self.moodTypes = moodTypes
            }
            
        })
    }
    
    func initializeMoodTypes() {
        
        // Do not mess with this order
        
        self.createMoodType(text: "Miserable", icon: "mood1-icon", completion: { type, err in
            guard let newType = type, err == nil else {
                print("Error when creating Miserable mood type")
                return
            }
            self.moodTypes.append(newType)
        })
        
        self.createMoodType(text: "Sad", icon: "mood2-icon", completion: { type, err in
            guard let newType = type, err == nil else {
                print("Error when creating Sad mood type")
                return
            }
            self.moodTypes.append(newType)
        })
        
        self.createMoodType(text: "Indifferent", icon: "mood3-icon", completion: { type, err in
            guard let newType = type, err == nil else {
                print("Error when creating Indifferent mood type")
                return
            }
            self.moodTypes.append(newType)
        })
        
        self.createMoodType(text: "Happy", icon: "mood4-icon", completion: { type, err in
            guard let newType = type, err == nil else {
                print("Error when creating Happy mood type")
                return
            }
            self.moodTypes.append(newType)
        })
        
        self.createMoodType(text: "Awesome", icon: "mood5-icon", completion: { type, err in
            guard let newType = type, err == nil else {
                print("Error when creating Awesome mood type")
                return
            }
            self.moodTypes.append(newType)
        })
    }
    
    private func createMoodType(text: String, icon: String, completion: @escaping (MoodType?, DataAccessError?) -> (Void)) {
        if let newMoodType = CoreDataManager.shared.create(type: MoodType.self) {
            newMoodType.typeIcon = icon
            newMoodType.typeText = text
            CoreDataManager.shared.saveContext()
            
            completion(newMoodType, nil)
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
    
    func fetchAll(completion: @escaping ([MoodInput]?, DataAccessError?) -> (Void)) {
        if let allMoodInputs = CoreDataManager.shared.fetch(MoodInput.self) {
            completion(allMoodInputs, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all mood inputs"))
        }
    }
    
    func fetchByDay(_ day: Date, completion: @escaping ([MoodInput]?, DataAccessError?) -> (Void)) {
        self.fetchAll(completion: { moodInputs, err in
            completion(moodInputs?.filter({ Calendar.current.isDate($0.date! as Date, inSameDayAs: day) }), err)
        })
    }
    
    func fetchSinceDay(_ day: Date, completion: @escaping ([MoodInput]?, DataAccessError?) -> (Void)) {
        self.fetchAll(completion: { moodInputs, err in
            completion(moodInputs?.filter({ day < $0.date! as Date }), err)
        })
    }
    
}
