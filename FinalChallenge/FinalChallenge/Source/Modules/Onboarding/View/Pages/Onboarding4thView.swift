//
//  Onboarding4thView.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 26/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import UIKit

class Onboarding4thView: OnboardingPageView {
    
    @IBOutlet weak var questionsFrame: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.questionsFrame.layer.cornerRadius = self.questionsFrame.frame.width / 2
        self.questionsFrame.clipsToBounds = true
    }
    
}
