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
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let viewController = segue.destination as? DaySummaryTableViewController {
            viewController.summaryView = self
        }

        if let viewController = segue.destination as? CalendarViewController {
            viewController.summaryView = self
        }
        
    }
    
}
