//
//  UserProfileCell.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 07/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class UserProfileCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var statisticsView: UIView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var daysInRowLabel: UILabel!
    @IBOutlet weak var questionsAnsweredLabel: UILabel!
    @IBOutlet weak var moodsInputedLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.userProfileImage.layer.cornerRadius = self.userProfileImage.frame.width / 2
        self.userProfileImage.clipsToBounds = true
        self.statisticsView.layer.cornerRadius = self.statisticsView.frame.width / 20
        self.statisticsView.clipsToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUsername(_ user: User) {
        
    }
    
    func setStatistics(_ stats: StatisticsDTO) {
        self.daysInRowLabel.text = "\(stats.daysInARow)"
        self.questionsAnsweredLabel.text = "\(stats.questionsAnswered)"
        self.moodsInputedLabel.text = "\(stats.moodsInputed)"
    }

}
