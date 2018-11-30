//
//  OnboardingPageView.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 22/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class OnboardingPageView: UIViewController {
    
    var pageViewController: OnboardingView!
    
    var background: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpBackground()
    }
    
    private func setUpBackground() {
        self.background = UIImageView.init(frame: self.view.frame)
        self.background.image = UIImage(named: "bgCloud")
        self.background.contentMode = .scaleAspectFill
        self.view.addSubview(self.background)
        self.background.layer.zPosition = -1
    }

}
