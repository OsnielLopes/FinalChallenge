//
//  CalendarViewController.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 10/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class DailySummaryViewController: UIViewController, DaySummaryPresenterOutputProtocol {
    
    @IBOutlet weak var calendarContainerView: UIView!
    @IBOutlet weak var calendarBorderView: UIView!
    var daySummaryTableViewController: DaySummaryTableViewController!
    var calendarViewController: CalendarViewController!
    
    // MARK: - Viper Module Properties
    var presenter: DaySummaryPresenterInputProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        let cornerRadiusValue = self.calendarBorderView.frame.size.width / 15
        
        self.calendarContainerView.layer.cornerRadius = cornerRadiusValue
        self.calendarContainerView.clipsToBounds = true
        
        self.calendarBorderView.layer.cornerRadius = cornerRadiusValue
        self.calendarBorderView.clipsToBounds = true
        
        self.calendarBorderView.dropShadow(color: UIColor(red: 18/255, green: 40/255, blue: 37/255, alpha: 1), opacity: 0.25, offSet: CGSize(width: 0, height: 5), radius: 20, scale: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewController = segue.destination as? DaySummaryTableViewController {
            self.daySummaryTableViewController = viewController
            viewController.dailySummaryParentViewController = self
        }

        if let viewController = segue.destination as? CalendarViewController {
            self.calendarViewController = viewController
            viewController.dailySummaryParentViewController = self
        }
        
    }
    
    func loadTodayEntries() {
        self.presenter.loadTodayEntries()
    }
    
    func loadMoodTypes() {
        self.presenter.loadMoodTypes()
    }
    
    func numberOfSections() -> Int {
        return self.presenter.numberOfSections()
    }
    
    func numberOfEntries(in section: Int) -> Int {
        return self.presenter.numberOfEntries(in: section)
    }
    
    func item(at indexPath: Int) -> Any {
        return self.presenter.item(at: indexPath)
    }
    
    func didTapInsert(mood index: Int) {
        self.presenter.didTapInsert(mood: index)
    }
    
    func didTapInsertQuestion() {
        self.presenter.didTapInsertQuestion()
    }
    
    func shouldShowAddButton() -> Bool {
        return self.presenter.shouldShowAddButton()
    }
    
    func shouldDisplayLine(for index: Int) -> Bool {
        return self.presenter.shouldDisplayLine(for: index)
    }
    
    func showLoading(_ loading: Bool) {
        self.daySummaryTableViewController.showLoading(loading)
    }
    
    func showError(message: String) {
        self.daySummaryTableViewController.showError(message: message)
    }
    
    func didFetchEntries() {
        self.daySummaryTableViewController.didFetchEntries()
    }
    
    func didFetch(moodTypes: [MoodType]) {
        self.daySummaryTableViewController.didFetch(moodTypes: moodTypes)
    }
    
    func didAddedMood() {
        self.daySummaryTableViewController.didAddedMood()
    }
    
    func setCurrentDate(_ date: Date) {
        self.presenter.setCurrentDate(date)
    }
    
}
