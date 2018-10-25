//
//  DailySummaryRouter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 25/10/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class DailySummaryRouter: NSObject, DailySummaryRouterProtocol {
    
	// MARK: - Constants
	private let storyBoardName = "DailySummary"
	private let viewIdentifier = "DailySummaryView"

	// MARK: - Viper Module Properties
	weak var view: DailySummaryViewController!
//    var calendarRouter: CalendarRouter!
    var daySummaryRouter: DaySummaryRouter!

	// MARK: - Constructors
	override init() {
		super.init()

		let view = self.viewControllerFromStoryboard()
		let presenter = DailySummaryPresenter()

		presenter.router = self
		view.presenter = presenter

		self.view = view
	}

    // MARK: - DailySummaryRouterProtocol
    
    func presentAsRoot(window: UIWindow) {
        window.rootViewController = self.view
    }
    
    func willPresentSummaryView(_ view: DaySummaryTableViewController) {
        self.daySummaryRouter = DaySummaryRouter(view: view)
        self.daySummaryRouter.dailySummaryRouter = self
    }
    
    func willPresentCalendarView(_ view: CalendarViewController) {
        // FIXME: - Waiting for calendar view VIPER submodules
    }
    
    func getCurrentDate() -> Date {
        // FIXME: - Waiting for calendar view VIPER submodules
        return Date()
    }

	// MARK: - Private methods
	private func viewControllerFromStoryboard() -> DailySummaryViewController {
		let storyboard = UIStoryboard(name: self.storyBoardName, bundle: nil)
		let viewController = storyboard.instantiateViewController(withIdentifier: self.viewIdentifier)

		return viewController as! DailySummaryViewController
	}
    
}
