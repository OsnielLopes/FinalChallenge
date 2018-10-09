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
    
    private init() {}
    
    func fetchMoodTypes(completion: @escaping ([MoodType]?, DataAccessError?) -> (Void)) {
        if let allMoodTypes = CoreDataManager.shared.fetch(MoodType.self) {
            completion(allMoodTypes, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all mood types"))
        }
    }
    
}
