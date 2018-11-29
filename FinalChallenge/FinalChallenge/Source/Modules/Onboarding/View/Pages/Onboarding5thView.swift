//
//  Onboarding6thView.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 26/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class Onboarding5thView: OnboardingPageView {
    
    @IBOutlet weak var profileImage: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.profileImage.layer.cornerRadius = self.profileImage.frame.width / 2
        self.profileImage.clipsToBounds = true
    }

}
