//
//  QuestionAnswersView.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 01/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class QuestionAnswersView: UIViewController, QuestionAnswersPresenterOutputProtocol, UITableViewDataSource, UITableViewDelegate {

	// MARK: - Viper Module Properties
	var presenter: QuestionAnswersPresenterInputProtocol!
    
    // MARK: - Outlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let questionReuseIdentifier = "questionTextCell"
    let answerReuseIdentifier = "answerCell"
    
    // MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 40.0

        self.view.hero.id = "\(self.presenter.fetchQuestion().objectID)cardView"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.presenter.fetchAnswers()
    }

    // MARK: - QuestionAnswersPresenterOutputProtocol
    func showLoading(_ loading: Bool) {
        // FIX-ME: - Implement loading
    }
    
    func showError(message: String) {
        //FIX-ME: - Implement error handling
    }
    
    func reloadData() {
        self.tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entity = self.presenter.item(at: indexPath.row)
        
        if let question = entity as? Question {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.questionReuseIdentifier) as? QuestionTextCell else {
                return UITableViewCell()
            }
            cell.setQuestion(question)
            cell.tableView = self
            
            return cell
        } else if let answer = entity as? Answer {
            guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.questionReuseIdentifier) as? AnswerCell else {
                return UITableViewCell()
            }
            cell.setAnswer(answer)
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func dissmiss() {
        self.presenter.didTapToDismiss()
    }

	// MARK: - Private Methods

}
