//
//  Onboarding2thView.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 22/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class Onboarding3thView: OnboardingPageView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var addButton: UIView!
    @IBOutlet weak var moodButton: UIView!
    @IBOutlet weak var questionButton: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.addButton.layer.cornerRadius = self.addButton.frame.width / 2
        self.addButton.clipsToBounds = true
        self.addButton.dropShadow(color: .black, opacity: 0.3, offSet: CGSize(width: 0, height: 2), radius: 2, scale: true)
        
        self.moodButton.layer.cornerRadius = self.moodButton.frame.width / 2
        self.moodButton.clipsToBounds = true
        self.moodButton.dropShadow(color: .black, opacity: 0.3, offSet: CGSize(width: 0, height: 2), radius: 2, scale: true)
        
        self.questionButton.layer.cornerRadius = self.questionButton.frame.width / 2
        self.questionButton.clipsToBounds = true
        self.questionButton.dropShadow(color: .black, opacity: 0.3, offSet: CGSize(width: 0, height: 2), radius: 2, scale: true)
    }

}
