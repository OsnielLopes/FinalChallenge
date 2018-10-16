//
//  RoundedUIButton.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 11/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class RoundedUIButton: UIButton {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.layer.cornerRadius = rect.width/2
        self.layer.masksToBounds = true
    }


}
