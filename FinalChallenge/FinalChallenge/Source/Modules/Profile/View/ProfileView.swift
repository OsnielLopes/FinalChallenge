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
    let chartCell = "chartCell"
    var userProfileCell: UserProfileCell?
    var inputedMoodsCell: ChartCell?
    var guessedMoodsCell: ChartCell?
    var midnfullnesTimeCell: ChartCell?
    
    
    // MARK: - Override methods
	override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.tableView.reloadData()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.reloadData), name: .mood, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.inputedMoodsCell?.setChartContentOffset()
        self.guessedMoodsCell?.setChartContentOffset()
        self.midnfullnesTimeCell?.setChartContentOffset()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    // MARK: - ProfilePresenterOutputProtocol
    
    func showError(message: String) {
        //FIXME: present the error message on view!
    }
    
    func showErrors(message: [String]) {
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
        self.midnfullnesTimeCell?.setChart(forData: results)
    }
    
    func didFetchStatistics(_ results: StatisticsDTO) {
        self.userProfileCell?.setStatistics(results)
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            guard let userProfileCell = tableView.dequeueReusableCell(withIdentifier: self.profileCellIdentifier, for: indexPath) as? UserProfileCell else {
                return UITableViewCell()
            }
            self.userProfileCell = userProfileCell
            
            if userProfileCell.shouldRecalculateStats {
                self.presenter.fetchStatistics()
            }
            
            return userProfileCell
        case 1:
            guard let emotionsChartCell = tableView.dequeueReusableCell(withIdentifier: self.chartCell, for: indexPath) as? ChartCell else {
                return UITableViewCell()
            }
            self.inputedMoodsCell = emotionsChartCell
            self.inputedMoodsCell!.profileView = self
            
            if self.inputedMoodsCell!.shouldRecalculateChart {
                self.presenter.fetchInputedEmotions(withOption: emotionsChartCell.getSelectedDisplayOption())
            }
            
            return emotionsChartCell
        case 2:
            guard let mindfullnessChartCell = tableView.dequeueReusableCell(withIdentifier: self.chartCell, for: indexPath) as? ChartCell else {
                return UITableViewCell()
            }
            self.midnfullnesTimeCell = mindfullnessChartCell
            self.midnfullnesTimeCell!.profileView = self
            
            if self.midnfullnesTimeCell!.shouldRecalculateChart {
                self.presenter.fetchMindfullnessTime(withOption: mindfullnessChartCell.getSelectedDisplayOption())
            }
            
            return mindfullnessChartCell
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
    
    @objc func reloadData() {
        DispatchQueue.main.async {
            self.presenter.fetchStatistics()
            self.presenter.fetchInputedEmotions(withOption: self.inputedMoodsCell?.getSelectedDisplayOption() ?? .week)
        }
    }
    
    func fetchInputedEmotions(with option: ChartDisplayOptions) {
        self.presenter.fetchInputedEmotions(withOption: option)
    }
    
    func fetchMindfullnessTime(with option: ChartDisplayOptions) {
        self.presenter.fetchMindfullnessTime(withOption: option)
    }

	// MARK: - Private Methods

}
