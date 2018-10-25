//
//  InsertTableViewCell.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 16/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class InsertTableViewCell: UITableViewCell {
    
    @IBOutlet weak var insertButton: UIButton!
    @IBOutlet weak var lineView: UIView!
    var moodButtons: [UIButton] = []
    var insertButtons: [UIButton] = []
    var questionButton: UIButton!
    var isInsertMenuClosed = true
    var isInsertMoodMenuClosed = true
    var shouldReloadCell = true
    var daySummaryTableViewController: DaySummaryTableViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.insertButton.layer.cornerRadius = self.insertButton.frame.height / 2
        self.insertButton.clipsToBounds = true
        self.insertButton.dropShadow(color: .black, opacity: 0.3, offSet: CGSize(width: 0, height: 2), radius: 2, scale: true)
    }
    
    func setButtons(forMoodTypes moodTypes: [MoodType]) {
        if !self.shouldReloadCell { return }
        
        var i = 0
        for mood in moodTypes {
            let button = self.instantiateMoodButton(forMoodImage: UIImage(named: mood.typeIcon!)!)
            button.tag = i
            button.addTarget(self, action: #selector(didTapToAddMood(_:)), for: .touchUpInside)
            i += 1
            self.moodButtons.append(button)
        }
        
        self.questionButton = self.instantiateMenuButton(forImage: UIImage(named: "question-icon")!)
        questionButton.addTarget(self, action: #selector(didTapQuestionButton), for: .touchUpInside)
        self.insertButtons.append(self.questionButton)
        
        let moodButton = self.instantiateMenuButton(forImage: UIImage(named: "mood3-icon")!)
        moodButton.addTarget(self, action: #selector(didTapMoodButton), for: .touchUpInside)
        self.insertButtons.append(moodButton)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.shouldReloadCell = false
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
        newInsertButton.dropShadow(color: .black, opacity: 0.3, offSet: CGSize(width: 0, height: 2), radius: 2, scale: true)
        self.addSubview(newInsertButton)
        return newInsertButton
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
    
    @objc func didTapMoodButton() {
        self.openMoodMenu()
    }
    
    @objc func didTapToAddMood(_ moodButton: Any) {
        guard let button = moodButton as? UIButton else {
            return
        }
        self.closeMoodMenu(completion: {
            self.daySummaryTableViewController.didTapInsertMood(button.tag)
        })
    }
    
    @objc func didTapQuestionButton() {
        self.daySummaryTableViewController.didTapInsertQuestion(insertButton: self.questionButton)
    }
}

extension InsertTableViewCell {
    
    // MARK: Animations
    
    func openInsertMenu(completion: (() -> (Void))? = nil) {
        self.isInsertMenuClosed = false
        UIView.animate(withDuration: 0.25, animations: {
            self.insertButton.transform = CGAffineTransform.init(rotationAngle: (-45 * CGFloat.pi) / 180)
        })
        self.openMenu(forButtons: self.insertButtons)
    }
    
    func closeInsertMenu(completion: (() -> (Void))? = nil) {
        self.isInsertMenuClosed = true
        UIView.animate(withDuration: 0.25, animations: {
            self.insertButton.transform = CGAffineTransform(rotationAngle: 0)
        })
        self.closeMenu(forButtons: self.insertButtons, i: self.insertButtons.count, completion: {
            completion?()
        })
    }
    
    func openMoodMenu(completion: (() -> (Void))? = nil) {
        self.isInsertMoodMenuClosed = false
        UIView.animate(withDuration: 0.25, animations: {
            self.insertButton.transform = CGAffineTransform(rotationAngle: 0)
        })
        self.closeMenu(forButtons: self.insertButtons, i: self.insertButtons.count, completion: {
            UIView.animate(withDuration: 0.25, animations: {
                self.insertButton.transform = CGAffineTransform.init(rotationAngle: (-45 * CGFloat.pi) / 180)
            })
            self.openMenu(forButtons: self.moodButtons)
        })
    }
    
    func closeMoodMenu(completion: (() -> (Void))? = nil) {
        self.isInsertMoodMenuClosed = true
        self.isInsertMenuClosed = true
        UIView.animate(withDuration: 0.25, animations: {
            self.insertButton.transform = CGAffineTransform(rotationAngle: 0)
        })
        self.closeMenu(forButtons: self.moodButtons, i: self.moodButtons.count, completion: {
            completion?()
        })
    }
    
    func openMenu(forButtons buttons: [UIButton], i: Int = 1, completion: (() -> (Void))? = nil) {
        
        if i >= buttons.count + 1 {
            completion?()
            return
        }
        
        UIView.animate(withDuration: 0.15, animations: {
            for j in stride(from: buttons.count, to: i - 1, by: -1) {
                buttons[j - 1].transform = CGAffineTransform(translationX: (buttons[j - 1].frame.width + 10) * CGFloat(i), y: 0)
            }
            buttons[i - 1].alpha = 1
        }, completion: { _ in
            self.openMenu(forButtons: buttons, i: i + 1, completion: completion)
            self.openMenu(forButtons: buttons, i: i + 2, completion: completion)
        })
    }
    
    func closeMenu(forButtons buttons: [UIButton], i: Int, completion: (() -> (Void))? = nil) {
        
        for i in stride(from: buttons.count, to: 0, by: -1) {
            
            UIView.animate(withDuration: 0.25, animations: {
                buttons[i - 1].transform = CGAffineTransform(translationX: self.insertButton.frame.origin.x, y: 0)
                buttons[i - 1].alpha = 0
            }, completion: { _ in
                if i == 1 { completion?() }
            })
            
        }
        
//        if i <= 0 { completion?(); return }
//
//        UIView.animate(withDuration: 0.15, animations: {
//
////            let destPoint = i - 2 > 0 ? buttons[i - 2].frame.origin.x : self.insertButton.frame.origin.x
//
//            for j in i...buttons.count {
//                buttons[j - 1].transform = CGAffineTransform(translationX: self.insertButton.frame.origin.x, y: 0)
////                buttons[j - 1].transform = CGAffineTransform(translationX: destPoint, y: 0)
//            }
//            buttons[i - 1].alpha = 0
//        }, completion: { _ in
//            self.closeMenu(forButtons: buttons, i: i - 1, completion: completion)
//        })
    }
    
}
