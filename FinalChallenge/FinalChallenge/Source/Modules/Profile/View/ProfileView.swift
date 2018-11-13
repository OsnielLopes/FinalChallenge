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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tableView.contentOffset = CGPoint.zero
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.tableView.reloadData()
    }

    // MARK: - ProfilePresenterOutputProtocol
    func showError(message: String) {
        //FIXME: present the error message on view!
    }
    func showLoadInputedMoodsData(_ loading: Bool) {
        //FIXME: add activity controll on view if loading is true, otherwise, remove loading
    }
    
    func showLoadGuessedEmotions(_ loading: Bool) {
        //FIXME: add activity controll on view if loading is true, otherwise, remove loading
    }
    
    func showLoadMindfullnessTime(_ loading: Bool) {
        //FIXME: add activity controll on view if loading is true, otherwise, remove loading
    }
    
    func showLoadStatistics(_ loading: Bool) {
        //FIXME: add activity controll on view if loading is true, otherwise, remove loading
    }
    
    func didFetchInputedMoodsData(_ results: EmotionChartDTO) {
        self.inputedMoodsCell?.setChart(forData: results)
    }
    
    func didFetchGuessedEmotions(_ results: EmotionChartDTO) {
        self.guessedMoodsCell?.setChart(forData: results)
    }
    
    func didFetchMindfullnessTime(_ results: MindfullnessTimeDTO) {
        fatalError()
    }
    
    func didFetchStatistics(_ results: StatisticsDTO) {
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
            self.inputedMoodsCell = emotionsChartCell
            self.inputedMoodsCell!.profileView = self
            self.presenter.fetchInputedEmotions(withOption: emotionsChartCell.getSelectedDisplayOption())
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
            return 350
        default:
            return UITableView.automaticDimension
        }
    }
    
    // MARK: - Public methods
    
    func fetchInputedEmotions(with option: ChartDisplayOptions) {
        self.presenter.fetchInputedEmotions(withOption: option)
    }

	// MARK: - Private Methods

}
