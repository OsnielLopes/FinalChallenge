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
    
    // MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        self.loadData()
    }

    // MARK: - ProfilePresenterOutputProtocol
    func loadData() {
        self.tableView.reloadData()
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
            return userProfileCell
        case 1:
            guard let emotionsChartCell = tableView.dequeueReusableCell(withIdentifier: self.emotionsChartCell, for: indexPath) as? EmotionsChartCell else {
                return UITableViewCell()
            }            
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
        default:
            return UITableView.automaticDimension
        }
    }

	// MARK: - Private Methods

}
