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
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setMood(_ mood: MoodInput) {
        
        let type = mood.moodType!
        let dateComponents = Calendar.current.dateComponents([.hour, .minute], from: mood.date! as Date)
        
        guard let hourInt = dateComponents.hour, let minuteInt = dateComponents.minute else {
            return
        }
        
        self.moodText.text = "I was feeling "+type.typeText!+" at \(String(describing: hourInt)):\(String(describing: minuteInt))"
        self.moodImage.image = UIImage.init(named: "daily" + type.typeIcon!)!
    }

}
