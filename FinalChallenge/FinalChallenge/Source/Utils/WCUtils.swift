//
//  Error.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 27/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

enum TransferError {
    case error(String)
}

enum Request: Int {
    case moods
}

enum Mood: Int {
    case awesome, happy, indifferent, sad, miserable
}
