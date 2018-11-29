//
//  Onboarding7thView.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 26/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class Onboarding6thView: OnboardingPageView {
    
    @IBOutlet weak var healthDataButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.healthDataButton.layer.cornerRadius = self.healthDataButton.frame.width / 10
        self.healthDataButton.clipsToBounds = true
        
    }
    
    // FIXME :- Implementation incorrect, but faster
    @IBAction func didPressToAllowAccess(_ sender: Any) {
        HealthKitManager.shared.askForPermission(completion: { succ, err in
            DispatchQueue.main.async {
                guard err == nil else {
                    self.alertUser(withTitle: "Warning", andMessage: "There was an error while granting permission to your health data")
                    return
                }
                self.healthDataButton.isEnabled = false
                if !succ {
                    self.healthDataButton.setTitle("Permission granted succesfully", for: .disabled)
                    self.healthDataButton.backgroundColor = UIColor.init(red: 124/255, green: 224/255, blue: 102/255, alpha: 1)
                } else {
                    self.healthDataButton.setTitle("You didn't grant us permission :(", for: .disabled)
                    self.healthDataButton.backgroundColor = #colorLiteral(red: 0.937254902, green: 0.4509803922, blue: 0.431372549, alpha: 1)
                }
            }
        })
    }
    
    private func alertUser(withTitle title: String, andMessage message: String) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
