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
    var daySummaryViewController: UIViewController!
    var presenter: BreathingPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.breathingAnimationImageView.image = UIImage.gifImageWithName("giphy")
    }

    @IBAction func didTapViewToContinue(_ sender: Any) {
        self.presenter.didTapViewToContinue()
    }
    
}
