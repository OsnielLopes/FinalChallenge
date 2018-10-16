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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    

    // MARK: - IBActions
    
    @IBAction func backButtonPressed() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func saveButtonPressed() {
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
