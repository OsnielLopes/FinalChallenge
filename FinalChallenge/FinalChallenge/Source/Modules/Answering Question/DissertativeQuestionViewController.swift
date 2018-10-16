//
//  AnswerQuestionViewController.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class DissertativeQuestionViewController: UIViewController {
    
    //MARK: - IBOutles
    @IBOutlet weak var question: UILabel!
    
    //MARK: - Properties

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - IBActions
    
    @IBAction func backButtonPressed() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func saveButtonPressed() {
    }

}
