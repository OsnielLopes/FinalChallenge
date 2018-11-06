//
//  AnswerCell.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 01/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class AnswerCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var answerTextLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var squareView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.squareView.layer.cornerRadius = self.squareView.frame.width / 2
        self.squareView.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAnswer(_ answer: Answer) {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        self.dateLabel.text = df.string(from: answer.date! as Date)
        if let answer = answer as? DissertationAnswer {
            self.answerTextLabel.text = answer.text
        } // else if let answer = answer as? CheckboxAnswer {
        // FIXME: Checkbox text
        //} else if let answer = answer as? RadioboxAnswer {
        // FIXME: Radiobox text
        //}
    }

}
