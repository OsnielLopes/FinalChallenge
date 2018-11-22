//
//  StatisticsDTO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 08/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class StatisticsDTO {
    
    var user: User
    var daysInARow: Int
    var questionsAnswered: Int
    var moodsInputed: Int
    
    init(user: User, daysInARow: Int, questionsAnswered: Int, moodsInputed: Int) {
        self.user = user
        self.daysInARow = daysInARow
        self.questionsAnswered = questionsAnswered
        self.moodsInputed = moodsInputed
    }
    
}
