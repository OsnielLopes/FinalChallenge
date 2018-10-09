//
//  CalendarCollectionViewCell.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 03/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class CalendarCollectionViewCell: UICollectionViewCell {
    
    // IBOutlets
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var background: UIView!
    
    var day: Date! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "pt_BR")
            dateFormatter.dateFormat = "d"
            label.text = day != nil ? dateFormatter.string(from: day) : ""
        }
    }
    override var isSelected: Bool {
        didSet {
            let calendar = Calendar(identifier: .gregorian)
            var isToday = false
            if isSelected {
                if day != nil {
                    isToday = calendar.component(.year, from: Date()) == calendar.component(.year, from: day) && calendar.component(.month, from: Date()) == calendar.component(.month, from: day) && calendar.component(.day, from: Date()) == calendar.component(.day, from: day)
                }
                label.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            } else {
                label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)  
            }
            background.isHidden = !isSelected
            background.backgroundColor = isToday ? #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
}
