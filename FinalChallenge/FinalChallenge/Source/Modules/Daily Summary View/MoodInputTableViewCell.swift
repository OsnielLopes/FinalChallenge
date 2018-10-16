//
//  MoodInputTableViewCell.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 15/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class MoodInputTableViewCell: UITableViewCell {

    @IBOutlet weak var moodText: UILabel!
    
    @IBOutlet weak var moodImage: UIImageView!
    
    @IBOutlet weak var lineView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setMood(_ mood: MoodInput) {
        
        let type = mood.moodType!
        
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let hourString = formatter.string(from: mood.date! as Date)
        
        self.moodText.text = "I was feeling "+(type.typeText!).lowercased()+" at \(hourString)"
        self.moodImage.image = UIImage.init(named: "daily" + type.typeIcon!)!
    }

}
