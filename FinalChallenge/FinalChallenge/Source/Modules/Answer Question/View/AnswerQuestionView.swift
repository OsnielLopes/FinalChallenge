//
//  AnswerQuestionView.swift
//  FinalChallenge
//
//  Created Ana Carolina Silva on 05/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class AnswerQuestionView: UIViewController, AnswerQuestionPresenterOutputProtocol, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Outlets
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var answerTableView: UITableView!
    @IBOutlet weak var bottomTableViewConstraint: NSLayoutConstraint!
    
    // MARK: - Properties
    private let dissertativeAnswerCellIdentifier = "dissertationCellIdentifier"
    private let checkboxAnswerCellIdentifier = "checkboxCellIdentifier"
    private let radioboxAnswerCellIdentifier = "radioboxCellIdentifier"
    
    private var keyboardSize: CGFloat = 0
    private var isKeyboardAvailable = false
    
	// MARK: - Viper Module Properties
	var presenter: AnswerQuestionPresenterInputProtocol!

	// MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.answerTableView.delegate = self
        self.answerTableView.dataSource = self
        
        self.presenter.loadCurrentQuestion()
    }

    // MARK: - AnswerQuestionPresenterOutputProtocol
    func showLoading(_ loading: Bool) {
        
    }
    
    func showQuestion(with title: String) {
        self.questionTextLabel.text = title
    }
    
    func showError(with message: String) {
        
    }
    
    func reloadData() {
        if self.presenter.questionType() == .dissertative {
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
            
            self.answerTableView.isScrollEnabled = false
        }
        
        self.answerTableView.reloadData()
    }
    
	// MARK: - Private Methods
    
    // MARK: - Table View Data Source and Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.presenter.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.dissertativeAnswerCellIdentifier, for: indexPath)
        
        //        if let dailyCell = cell as? DailyQuestionCollectionViewCell {
        //            let question: Question = self.presenter.item(at: indexPath.row)
        //
        //            dailyCell.categoryLabel.text = question.category?.name
        //            dailyCell.dailyQuestionLabel.text = question.questionText
        //
        //            return dailyCell
        //        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.presenter.questionType() == .dissertative {
            if isKeyboardAvailable {
                return self.answerTableView.frame.height - self.keyboardSize
            } else {
                return self.answerTableView.frame.height
            }
        }
        
        return UITableView.automaticDimension
    }
    
    // MARK: - Notification Keyboard
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            print("notification: Keyboard will show")
            if !self.isKeyboardAvailable {
                self.isKeyboardAvailable = true
                self.keyboardSize = keyboardSize.height - self.bottomTableViewConstraint.constant/2
                self.answerTableView.beginUpdates()
                self.answerTableView.endUpdates()
                self.answerTableView.visibleCells.first!.contentView.layoutSubviews()
            }
        }
        
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.isKeyboardAvailable {
                self.isKeyboardAvailable = false
                self.answerTableView.beginUpdates()
                self.answerTableView.endUpdates()
            }
        }
    }
    
    // MARK: - Actions
    @IBAction func touchBackButton(_ sender: RoundedUIButton) {
        self.presenter.didTouchBackButton()
    }
    
    @IBAction func touchSaveButton(_ sender: RoundedUIButton) {
        self.presenter.didTouchSaveButton(with: ["teste"])
    }

}
