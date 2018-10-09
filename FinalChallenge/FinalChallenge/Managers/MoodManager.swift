//
//  MoodManager.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class MoodManager {
    
    static let shared = MoodManager()
    
    var moodTypes: [MoodType]
    
    private init() {
        self.moodTypes = []
        MoodDAO.shared.fetchMoodTypes(completion: { moodTypes, err in
            self.moodTypes = moodTypes ?? []
        })
    }
}
