//
//  DailyQuestionCollectionViewCell.swift
//  FinalChallenge
//
//  Created by Ana Carolina Silva on 04/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit
import CoreMotion

class DailyQuestionCollectionViewCell: BaseRoundedCardCollectionViewCell {
    
    // MARK: - Outlets
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var dailyQuestionLabel: UILabel!
    @IBOutlet weak var questionAnswerLabel: UILabel!
    @IBOutlet weak var cornerView: UIView!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.cornerView.layer.cornerRadius = 10.0
        self.cornerView.clipsToBounds = false
        
        self.clipsToBounds = false
    }
}
