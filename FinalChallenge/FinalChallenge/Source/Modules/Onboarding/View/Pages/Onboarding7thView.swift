//
//  Onboarding8thView.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 26/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class Onboarding7thView: OnboardingPageView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var userImage: UIImageView!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var userBackground: UIImageView!
    
    @IBOutlet var changeImageGesture: UITapGestureRecognizer!
    @IBOutlet var changeBackgroundImageGesture: UITapGestureRecognizer!
    
    @IBOutlet weak var startReflectingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.userImage.layer.cornerRadius = self.userImage.frame.width / 2
        self.userImage.clipsToBounds = true
        
        self.startReflectingButton.layer.cornerRadius = self.startReflectingButton.frame.width / 10
        self.startReflectingButton.clipsToBounds = true        
        
        self.username.setBottomBorder(with: #colorLiteral(red: 0.01960784314, green: 0.06274509804, blue: 0.07843137255, alpha: 1), and: 1.0)
    }
    
    @IBAction func didTapChangeBackgroundImage(_ sender: Any) {
    }
    
    @IBAction func didTapChangeImage(_ sender: Any) {
    }
    
    @IBAction func didClickToStartReflecting(_ sender: Any) {
    }
}
