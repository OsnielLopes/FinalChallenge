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
    
    var questionButton: UIButton!
    
    @IBOutlet weak var lineView: UIView!
    
    var moodButtons: [UIButton] = []
    
    var insertButtons: [UIButton] = []
    
    var isInsertMenuClosed = true
    
    var isInsertMoodMenuClosed = true
    
    var daySummaryTableViewController: DaySummaryTableViewController!
    
    var shouldReloadCell = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.insertButton.layer.cornerRadius = self.insertButton.frame.height / 2
        self.insertButton.clipsToBounds = true
        self.insertButton.dropShadow(color: .black, opacity: 0.3, offSet: CGSize(width: 0, height: 2), radius: 2, scale: true)
    }
    
    func setButtons() {
        if !self.shouldReloadCell { return }
        
        var i = 0
        for mood in self.daySummaryTableViewController.moodTypes {
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
        self.daySummaryTableViewController.didTapInsertMood(button.tag)
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
