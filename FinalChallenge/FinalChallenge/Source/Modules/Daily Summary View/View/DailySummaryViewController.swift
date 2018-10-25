//
//  CalendarViewController.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 10/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class DailySummaryViewController: UIViewController, DailySummaryPresenterOutputProtocol {
    
    var currentDate: Date = Date()
    var daySummaryTableViewController: DaySummaryTableViewController!
    @IBOutlet weak var calendarContainerView: UIView!
    @IBOutlet weak var calendarBorderView: UIView!
    
    var presenter: DailySummaryPresenterInputProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cornerRadiusValue = self.calendarBorderView.frame.size.width / 15
        
        self.calendarContainerView.layer.cornerRadius = cornerRadiusValue
        self.calendarContainerView.clipsToBounds = true
        
        self.calendarBorderView.layer.cornerRadius = cornerRadiusValue
        self.calendarBorderView.clipsToBounds = true
        
        self.calendarBorderView.dropShadow(color: UIColor(red: 18/255, green: 40/255, blue: 37/255, alpha: 1), opacity: 0.25, offSet: CGSize(width: 0, height: 5), radius: 20, scale: true)
    }
    
    func reloadData() {
//        self.daySummaryTableViewController.loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewController = segue.destination as? DaySummaryTableViewController {
            viewController.summaryView = self
            self.daySummaryTableViewController = viewController
            self.presenter.willPresentSummaryView(viewController)
            
        }

        if let viewController = segue.destination as? CalendarViewController {
            viewController.summaryView = self
            self.presenter.willPresentCalendarView(viewController)
        }
        
    }
    
}
