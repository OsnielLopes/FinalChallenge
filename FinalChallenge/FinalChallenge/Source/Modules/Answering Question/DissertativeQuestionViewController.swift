//
//  AnswerQuestionViewController.swift
//  FinalChallenge
//
//  Created by Osniel Lopes Teixeira on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class DissertativeQuestionViewController: UIViewController {
    
    // TODO: Só permitir que o botão de salvar seja pressionado depois que o texto da text view for editado.
    // TOOD: Remover o texto default da textview após ela ser tocada e retorná-lo caso todo o texto seja apagado
    
    //MARK: - IBOutles
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    
    //MARK: - Properties
    var question: DissertationQuestion!

    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = question.questionText
    }
    

    // MARK: - IBActions
    
    @IBAction func backButtonPressed() {
        self.navigationController?.popViewController(animated: false)
    }
    
    @IBAction func saveButtonPressed() {
    }

}
