//
//  DailySummaryProtocols.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 25/10/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Router
protocol DailySummaryRouterProtocol: class {
    func presentAsRoot(window: UIWindow)
    
    func willPresentSummaryView(_ view: DaySummaryTableViewController)
    func willPresentCalendarView(_ view: CalendarViewController)
    
    func getCurrentDate() -> Date
}

// MARK: - Interactor

// MARK: - Presenter
protocol DailySummaryPresenterInputProtocol: class {
    func willPresentSummaryView(_ view: DaySummaryTableViewController)
    func willPresentCalendarView(_ view: CalendarViewController)
}

// MARK: - View
