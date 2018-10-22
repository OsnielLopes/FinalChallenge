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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.breathingAnimationImageView.image = UIImage.gifImageWithName("giphy")
    }

    @IBAction func didTapViewToContinue(_ sender: Any) {
        let storyboard = UIStoryboard(name: "DailyQuestion", bundle: nil)
        if let viewController = storyboard.instantiateViewController(withIdentifier: "DailyQuestionView") as? DailyQuestionView {
            viewController.summaryViewController = self.daySummaryViewController
            self.present(viewController, animated: true, completion: nil)
        }
    }
    
}
