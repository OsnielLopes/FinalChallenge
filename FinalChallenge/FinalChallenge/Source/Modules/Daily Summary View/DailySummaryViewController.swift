//
//  CalendarViewController.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 10/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import UIKit

class DailySummaryViewController: UIViewController {
    
    var currentDate: Date = Date()
    
    var daySummaryTableViewController: DaySummaryTableViewController!
    
    @IBOutlet weak var calendarContainerView: UIView!
    
    @IBOutlet weak var calendarBorderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let cornerRadiusValue = self.calendarBorderView.frame.size.width / 10
        
        self.calendarContainerView.layer.cornerRadius = cornerRadiusValue
        self.calendarContainerView.clipsToBounds = true
        
        self.calendarBorderView.layer.cornerRadius = cornerRadiusValue
        self.calendarBorderView.clipsToBounds = true
        
        self.calendarBorderView.dropShadow(color: .black, opacity: 0.5, offSet: CGSize(width: 0, height: 10), radius: 2, scale: true)
    }
    
    func reloadData() {
        self.daySummaryTableViewController.loadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewController = segue.destination as? DaySummaryTableViewController {
            viewController.summaryView = self
            self.daySummaryTableViewController = viewController
        }

        if let viewController = segue.destination as? CalendarViewController {
            viewController.summaryView = self
        }
        
    }
    
}
