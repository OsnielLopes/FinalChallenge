//
//  QuestionsHistoricCell.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 31/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class QuestionsHistoricCell: UITableViewCell {

    // MARK: - IBOutlets
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var questionAuthorLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cardView.layer.cornerRadius = self.cardView.frame.width / 30
        self.cardView.dropShadow(color: #colorLiteral(red: 0.01960784314, green: 0.06274509804, blue: 0.07843137255, alpha: 1), opacity: 0.25, offSet: CGSize.init(width: 0, height: 0), radius: 0, scale: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setQuestion(_ question: Question) {
        self.questionTextLabel.text = question.questionText
        self.questionAuthorLabel.text = "Por " + question.questionAuthor!.name!
    }

}
