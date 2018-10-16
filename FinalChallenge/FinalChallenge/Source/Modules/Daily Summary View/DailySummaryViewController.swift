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
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
