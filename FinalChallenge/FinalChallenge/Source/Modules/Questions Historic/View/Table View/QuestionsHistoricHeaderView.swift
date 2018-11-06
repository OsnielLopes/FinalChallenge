//
//  QuestionsHistoricHeaderView.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 31/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class QuestionsHistoricHeaderView: UIView {

    @IBOutlet weak var categoryTitleLabel: UILabel!
    
    func setCategory(_ category: Category) {
        self.categoryTitleLabel.text = "Sobre "+category.name!
    }

}
