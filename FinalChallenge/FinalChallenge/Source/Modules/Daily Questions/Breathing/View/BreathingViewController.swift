//
//  BreathingViewController.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 18/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class BreathingViewController: UIViewController {

    @IBOutlet weak var breathingAnimationImageView: UIImageView!
    @IBOutlet weak var aView: UIView!
    @IBOutlet weak var yposOfView: NSLayoutConstraint!
    @IBOutlet weak var widthOfView: NSLayoutConstraint!
    
    var daySummaryViewController: UIViewController!
    var presenter: BreathingPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.breathingAnimationImageView.image = UIImage.gifImageWithName("giphy")
        self.breathingAnimationImageView.isHidden = true
        
        yposOfView.constant = self.view.frame.height - (self.view.frame.height/1.6666666667) - (self.view.frame.height/2)
        widthOfView.constant = self.view.frame.width/1.6666666667
        
        aView.layer.cornerRadius = aView.frame.width/2
        
        self.openAnimation()
        
        
        self.view.hero.id = "insertQuestionButtonId"
        self.view.hero.modifiers = [.arc, .source(heroID: "insertQuestionButtonId")]

    }

    @IBAction func didTapViewToContinue(_ sender: Any) {
        self.presenter.didTapViewToContinue()
    }
    
    func openAnimation() {
        let animator = UIViewPropertyAnimator.init(duration: 3, curve: .easeInOut) {
            self.aView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        }
        animator.addCompletion { (position) in
            self.closeAnimation()
        }
        animator.startAnimation()
    }
    
    func closeAnimation() {
        let animator = UIViewPropertyAnimator.init(duration: 3, curve: .easeInOut) {
            self.aView.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
        animator.addCompletion { (position) in
            self.openAnimation()
        }
        animator.startAnimation()
    }
    
}
