//
//  QuestionTextCell.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 01/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class QuestionTextCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var questionAuthorLabel: UILabel!
    
    // MARK: - Properties
    var tableView: QuestionAnswersView!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.dismissButton.layer.cornerRadius = self.dismissButton.frame.width / 2
        self.dismissButton.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setting up cell
    func setQuestion(_ question: Question) {
        self.questionTextLabel.text = question.questionText
        self.questionAuthorLabel.text = "por "+question.questionAuthor!.name!
        
        self.questionTextLabel.hero.id = "\(question.objectID)textLabel"
        self.questionAuthorLabel.hero.id = "\(question.objectID)authorLabel"
    }

    // MARK: - IBActions
    @IBAction func didTapDismiss(_ sender: Any) {
        self.tableView.dissmiss()
    }
}
