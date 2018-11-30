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
        
        self.healthDataButton.layer.cornerRadius = self.healthDataButton.frame.width / 15
        self.healthDataButton.clipsToBounds = true
        self.healthDataButton.alpha = 0
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if self.healthDataButton.alpha == 0 {
            self.updateButton()
        }
    }
    
    // FIXME :- Implementation incorrect, but faster
    @IBAction func didPressToAllowAccess(_ sender: Any) {
        HealthKitManager.shared.askForPermission(completion: { fail, err in
            DispatchQueue.main.async {
                guard err == nil else {
                    self.alertUser(withTitle: "Warning", andMessage: "There was an error while granting permission to your health data")
                    return
                }
                self.updateButton()
            }
        })
    }
    
    private func alertUser(withTitle title: String, andMessage message: String) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // FIXME :- Implementation incorrect, but faster
    private func updateButton() {
        if let isAvailable = HealthKitManager.shared.isHealthDataAvailable() {
            self.healthDataButton.isEnabled = false
            if isAvailable {
                self.setButton(toState: .available)
            } else {
                self.setButton(toState: .notAvailable)
            }
        } else {
            self.setButton(toState: .def)
        }
    }
    
    private func setButton(toState: ButtonState) {
        if self.healthDataButton.alpha == 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.healthDataButton.alpha = 0
            })
        }
        switch toState {
        case .available:
            self.healthDataButton.isEnabled = false
            self.setButton(withTitle: "Permission was grant", andColor: UIColor(red: 124/255, green: 224/255, blue: 102/255, alpha: 1))
        case .notAvailable:
            self.healthDataButton.isEnabled = false
            self.setButton(withTitle: "You didn't grant us permission :(", andColor: #colorLiteral(red: 0.937254902, green: 0.4509803922, blue: 0.431372549, alpha: 1))
        case .def:
            UIView.animate(withDuration: 0.5, animations: {
                self.healthDataButton.alpha = 1
            })
        }
    }
    
    private func setButton(withTitle title: String, andColor color: UIColor) {
        self.healthDataButton.alpha = 1
        self.healthDataButton.setTitle(title, for: .disabled)
        self.healthDataButton.backgroundColor = color
        UIView.animate(withDuration: 0.5, animations: {
            self.healthDataButton.alpha = 1
        })
    }
    
    enum ButtonState {
        case available
        case def
        case notAvailable
    }
}
