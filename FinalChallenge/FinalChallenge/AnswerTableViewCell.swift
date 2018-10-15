//
//  AnswerTableViewCell.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 15/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class AnswerTableViewCell: UITableViewCell {

    @IBOutlet weak var answerQuestionText: UILabel!
    
    @IBOutlet weak var answerText: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setAnswer(_ answer: Answer) {
        self.answerQuestionText.text = answer.question?.questionText
        if let answer = answer as? DissertationAnswer {
            self.answerText.text = answer.text
        } // else if let answer = answer as? CheckboxAnswer {
            // FIXME: Checkbox text
        //} else if let answer = answer as? RadioboxAnswer {
            // FIXME: Radiobox text
        //}
    }

}
