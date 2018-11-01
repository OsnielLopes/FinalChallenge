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
    let reuseIdentifierCell = "questionTextCell"
    
    // MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 40.0
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
        guard let cell = self.tableView.dequeueReusableCell(withIdentifier: self.reuseIdentifierCell) else {
            return UITableViewCell()
        }
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

	// MARK: - Private Methods

}
