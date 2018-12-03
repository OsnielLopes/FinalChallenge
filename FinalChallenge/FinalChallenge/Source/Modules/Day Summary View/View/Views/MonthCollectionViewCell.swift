//
//  MonthCollectionViewCell.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 22/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {
    
    // Properties
    var label: UILabel!
    var background: UIView!
    
    var day: Date! {
        didSet {
            let dateFormatter = DateFormatter()
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.dateFormat = "d"
            label.text = day != nil ? dateFormatter.string(from: day) : ""
        }
    }
    override var isSelected: Bool {
        didSet {
            let calendar = Calendar(identifier: .gregorian)
            var isToday = false
            if day != nil {
                isToday = calendar.component(.year, from: Date()) == calendar.component(.year, from: day) && calendar.component(.month, from: Date()) == calendar.component(.month, from: day) && calendar.component(.day, from: Date()) == calendar.component(.day, from: day)
            }
            label.textColor = isSelected ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            background.isHidden = !isSelected
            background.backgroundColor = isToday ? #colorLiteral(red: 0.5807225108, green: 0.066734083, blue: 0, alpha: 1) : #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        background = UIView(frame: CGRect(x: (frame.width/2)-(frame.height/2), y: 0, width: frame.height, height: frame.height))
        self.addSubview(background)
        label = UILabel(frame: frame)
        label.frame.origin = CGPoint.zero
        label.textAlignment = .center
        self.addSubview(label)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
