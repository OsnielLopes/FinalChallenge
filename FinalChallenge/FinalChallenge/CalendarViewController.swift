//
//  CalendarViewController.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 10/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class CalendarViewController: UIViewController {

    @IBOutlet weak var moodMenuView: UIView!
    
    @IBOutlet weak var insertButton: UIButton!
    
    var moodButtons: [UIButton] = []
    
    var insertButtons: [UIButton] = []
    
    var isInsertMenuClosed = true
    
    var isInsertMoodMenuClosed = true
    
    var moodMenuIcons: [UIImage] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.insertButton.layer.cornerRadius = self.insertButton.frame.height / 2
        self.insertButton.clipsToBounds = true
        
        // MOCK
        self.moodMenuIcons = [UIImage.init(named: "mood1-icon")!,
                          UIImage.init(named: "mood2-icon")!,
                          UIImage.init(named: "mood3-icon")!,
                          UIImage.init(named: "mood4-icon")!,
                          UIImage.init(named: "mood5-icon")!]
        
        //END OF MOCK
        
        for menuIcon in self.moodMenuIcons {
            self.moodButtons.append(self.instantiateMoodButton(forMoodImage: menuIcon))
        }
        
        let questionButton = self.instantiateMenuButton(forImage: UIImage(named: "question-icon")!)
        questionButton.addTarget(self, action: #selector(didTapQuestionButton), for: .touchUpInside)
        self.insertButtons.append(questionButton)
        
        let moodButton = self.instantiateMenuButton(forImage: UIImage(named: "mood3-icon")!)
        moodButton.addTarget(self, action: #selector(didTapMoodButton), for: .touchUpInside)
        self.insertButtons.append(moodButton)

    }
    
    func instantiateMoodButton(forMoodImage image: UIImage) -> UIButton {
        let newMoodButton = self.instantiateMenuButton(forImage: image)
        return newMoodButton
    }
    
    func instantiateMenuButton(forImage image: UIImage) -> UIButton {
        let newInsertButton = UIButton(frame: self.insertButton.frame)
        newInsertButton.setImage(image, for: .normal)
        newInsertButton.backgroundColor = #colorLiteral(red: 1, green: 0.8392156863, blue: 0.3965210433, alpha: 1)
        newInsertButton.alpha = 0
        newInsertButton.layer.cornerRadius = newInsertButton.frame.height / 2
        newInsertButton.clipsToBounds = true
        self.moodMenuView.addSubview(newInsertButton)
        return newInsertButton
    }
    
    @objc func didTapMoodButton() {
       self.openMoodMenu()
    }
    
    @objc func didTapQuestionButton() {
        // Push add question view
    }
    
    @IBAction func didTapInsertButton(_ sender: Any) {
        if self.isInsertMenuClosed {
            self.openInsertMenu()
        } else {
            if self.isInsertMoodMenuClosed {
                self.closeInsertMenu()
            } else {
                self.closeMoodMenu()
            }
        }
    }

    func openInsertMenu(completion: (() -> (Void))? = nil) {
        self.isInsertMenuClosed = false
        UIView.animate(withDuration: 0.25, animations: {
            self.insertButton.transform = CGAffineTransform(rotationAngle: -45)
        })
        self.openMenu(forButtons: self.insertButtons)
    }
    
    func closeInsertMenu(completion: (() -> (Void))? = nil) {
        self.isInsertMenuClosed = true
        UIView.animate(withDuration: 0.25, animations: {
            self.insertButton.transform = CGAffineTransform(rotationAngle: 0)
        })
        self.closeMenu(forButtons: self.insertButtons, completion: {
            completion?()
        })
    }
    
    func openMoodMenu(completion: (() -> (Void))? = nil) {
        self.isInsertMoodMenuClosed = false
        self.closeMenu(forButtons: self.insertButtons, completion: {
            self.openMenu(forButtons: self.moodButtons)
        })
    }
    
    func closeMoodMenu(completion: (() -> (Void))? = nil) {
        self.isInsertMoodMenuClosed = true
        self.isInsertMenuClosed = true
        UIView.animate(withDuration: 0.25, animations: {
            self.insertButton.transform = CGAffineTransform(rotationAngle: 0)
        })
        self.closeMenu(forButtons: self.moodButtons)
    }
    
    func openMenu(forButtons buttons: [UIButton], completion: (() -> (Void))? = nil) {
        for i in 1...buttons.count {
            UIView.animate(withDuration: 0.3 + (Double(i) * 0.05), animations: {
                buttons[i - 1].transform = CGAffineTransform(translationX: (buttons[i - 1].frame.width + 10) * CGFloat(i), y: 0)
                buttons[i - 1].alpha = 1
                completion?()
            })
        }
    }
    
    func closeMenu(forButtons buttons: [UIButton], completion: (() -> (Void))? = nil) {
        for i in stride(from: buttons.count, to: 0, by: -1) {
            UIView.animate(withDuration: 0.3 + (Double(i) * 0.05), animations: {
                buttons[i - 1].transform = CGAffineTransform(translationX: self.insertButton.frame.origin.x, y: 0)
                buttons[i - 1].alpha = 0
                completion?()
            })
        }
    }
}
