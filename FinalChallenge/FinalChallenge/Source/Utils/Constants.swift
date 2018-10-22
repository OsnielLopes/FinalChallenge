//
//  Constants.swift
//  FinalChallenge
//
//  Created by Ana Carolina Silva on 17/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

// MARK: - Project Constants
enum Project {
    
    // MARK: - Colors
    enum Colors: String, ColorRepresentable {
        case black = "color-black"
        case blue = "color-blue"
        case lightBlue = "color-lightBlue"
        case red = "color-red"
        case white = "color-white"
        case yellow = "color-yellow"
    }
    
    // MARK: - Images
    enum Images {
        enum Button: String, ImageRepresentable {
            case moodOne = "mood1-icon"
            case moodTwo = "mood2-icon"
            case moodThree = "mood3-icon"
            case moodFour = "mood4-icon"
            case moodFive = "mood5-icon"
            case question = "question-icon"
            case remove = "remove-icon"
            case add = "add"
            case back = "back-arrow"
            case cancel = "cancel"
        }
        
        enum DailyTimeline: String, ImageRepresentable {
            case moodOne = "dailymood1-icon"
            case moodTwo = "dailymood2-icon"
            case moodThree = "dailymood3-icon"
            case moodFour = "dailymood4-icon"
            case moodFive = "dailymood5-icon"
            case question = "dailyQuestion-icon"
        }
    }
    
    // MARK: - Fonts
    enum FontFamily { }
    
    // MARK: - Localizable Strings
    enum Localizable {
        
        enum Question: String, LocalizeRepresentable, CaseIterable {
            static let author = "System"
            
            case q01 = "question.01"
            case q02 = "question.02"
            case q03 = "question.03"
            case q04 = "question.04"
            case q05 = "question.05"
            case q06 = "question.06"
            case q07 = "question.07"
            case q08 = "question.08"
            case q09 = "question.09"
            case q10 = "question.10"
            case q11 = "question.11"
            case q12 = "question.12"
            case q13 = "question.13"
            case q14 = "question.14"
            case q15 = "question.15"
            case q16 = "question.16"
            case q17 = "question.17"
            case q18 = "question.18"
            case q19 = "question.19"
            case q20 = "question.20"
            case q21 = "question.21"
            case q22 = "question.22"
            case q23 = "question.23"
            case q24 = "question.24"
            case q26 = "question.26"
            case q27 = "question.27"
            case q28 = "question.28"
            case q29 = "question.29"
            case q30 = "question.30"
            case q31 = "question.31"
            case q32 = "question.32"
            case q33 = "question.33"
            case q34 = "question.34"
            case q36 = "question.36"
            case q37 = "question.37"
            case q38 = "question.38"
            case q39 = "question.39"
            case q40 = "question.40"
            case q41 = "question.41"
            case q42 = "question.42"
            case q43 = "question.43"
            case q44 = "question.44"
            case q45 = "question.45"
            case q46 = "question.46"
            case q47 = "question.47"
            case q48 = "question.48"
            case q49 = "question.49"
            case q50 = "question.50"
            case q51 = "question.51"
            case q52 = "question.52"
            case q53 = "question.53"
            case q54 = "question.54"
            case q55 = "question.55"
            case q56 = "question.56"
            case q57 = "question.57"
            case q58 = "question.58"
            case q59 = "question.59"
            case q60 = "question.60"
            case q61 = "question.61"
            case q62 = "question.62"
            case q63 = "question.63"
            case q64 = "question.64"
            case q65 = "question.65"
            case q66 = "question.66"
            case q67 = "question.67"
            case q68 = "question.68"
            case q69 = "question.69"
            case q70 = "question.70"
            case q71 = "question.71"
            case q72 = "question.72"
            case q73 = "question.73"
            
            var category: String {
                switch self {
                default:
                    return "Default"
                }
            }
        }
    }
    
    // MARK: - UserDafaults
    enum UserSettings: String {
        case appHasBeenUsed = "appHasAlreadyBeenUsed"
        case appHasBeenUsedToday = "appHasAlreadyBeenUsedToday"
        case todayQuestions = "todayQuestions"
    }
    
    // MARK: - Categories
    
}

// MARK: - Representable Protocols
protocol ImageRepresentable: RawRepresentable {
    var image: UIImage { get }
}

protocol ColorRepresentable: RawRepresentable {
    var color: UIColor { get }
}

protocol LocalizeRepresentable: RawRepresentable {
    var localized: String { get }
}

// MARK: - Representable Protocols Extensions
extension ImageRepresentable where RawValue == String {
    var image: UIImage {
        guard let aImage = UIImage(named: rawValue) else { return UIImage() }
        return aImage
    }
}

extension ColorRepresentable where RawValue == String {
    var color: UIColor {
        guard let aColor = UIColor(named: rawValue) else { return UIColor.white }
        return aColor
    }
}

extension LocalizeRepresentable where RawValue == String {
    var localized: String {
        return NSLocalizedString(rawValue, comment: "")
    }
}
