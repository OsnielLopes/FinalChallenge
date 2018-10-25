//
//  DailySummaryPresenter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 25/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailySummaryPresenter: NSObject, DailySummaryPresenterInputProtocol, DailySummaryInteractorOutputProtocol {

	// MARK: - Viper Module Properties
    weak var view: DailySummaryPresenterOutputProtocol!
    var interactor: DailySummaryInteractorInputProtocol!
    var router: DailySummaryRouterProtocol!

    // MARK: - DailySummaryPresenterInputProtocol

    // MARK: - DailySummaryPresenterInteractorOutputProtocol
    func willPresentSummaryView(_ view: DaySummaryTableViewController) {
        self.router.willPresentSummaryView(view)
    }
    
    func willPresentCalendarView(_ view: CalendarViewController) {
        self.router.willPresentCalendarView(view)
    }
    

	// MARK: - Private Methods

}
