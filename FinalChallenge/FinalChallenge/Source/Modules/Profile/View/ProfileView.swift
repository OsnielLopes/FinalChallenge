//
//  ProfileView.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 07/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class ProfileView: UIViewController, ProfilePresenterOutputProtocol, UITableViewDelegate, UITableViewDataSource {

	// MARK: - Viper Module Properties
	var presenter: ProfilePresenterInputProtocol!
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Properties
    let profileCellIdentifier = "userProfileCell"
    let emotionsChartCell = "emotionsChartCell"
    var userProfileCell: UserProfileCell?
    var inputedMoodsCell: EmotionsChartCell?
    var guessedMoodsCell: EmotionsChartCell?
//    var midnfullnesTimeCel: MindfullnessTimeChartCell?
    
    
    // MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.tableView.reloadData()
    }

    // MARK: - ProfilePresenterOutputProtocol
    func loadInputedMoodsData() {
        fatalError()
    }
    
    func loadGuessedEmotions() {
        fatalError()
    }
    
    func loadMindfullnessTime() {
        fatalError()
    }
    
    func loadStatistics() {
        fatalError()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let userProfileCell = tableView.dequeueReusableCell(withIdentifier: self.profileCellIdentifier, for: indexPath) as? UserProfileCell else {
                return UITableViewCell()
            }
            self.userProfileCell = userProfileCell
            return userProfileCell
        case 1:
            guard let emotionsChartCell = tableView.dequeueReusableCell(withIdentifier: self.emotionsChartCell, for: indexPath) as? EmotionsChartCell else {
                return UITableViewCell()
            }
            self.presenter.fetchInputedEmotions(sinceDate: Calendar.current.date(byAdding: .day, value: -30, to: Date()) ?? Date())
            self.inputedMoodsCell = emotionsChartCell
            return emotionsChartCell
        default:
            break
        }
        return UITableViewCell()
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 357
        case 1, 2, 3:
            return 260
        default:
            return UITableView.automaticDimension
        }
    }

	// MARK: - Private Methods

}
