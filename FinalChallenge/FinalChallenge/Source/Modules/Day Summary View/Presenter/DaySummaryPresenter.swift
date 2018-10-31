//
//  DaySummaryPresenter.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 24/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class DaySummaryPresenter: NSObject, DaySummaryPresenterInputProtocol, DaySummaryInteractorOutputProtocol {

    // MARK: - Properties
    private var moodTypes: [MoodType] = []
    private var entries: [Any] = []
    private var didEndedFetchingMoodInputs = false
    private var didEndedFetchingAnswers = false
    var currentDate: Date = Date()
    
    // MARK: - Viper Module Properties
    weak var view: DaySummaryPresenterOutputProtocol!
    var interactor: DaySummaryInteractorInputProtocol!
    var router: DaySummaryRouterProtocol!    
    
    // MARK: - DaySummaryInteractorOutputProtocol
    func handleSuccessFetchedMoodTypes(with results: [MoodType]) {
        self.moodTypes = results
        self.view.didFetch(moodTypes: results)
    }
    
    func handleFailureFetchedMoodTypes(with message: String) {
        self.view.showError(message: message)
    }
    
    func handleSuccessFetchedMood(with results: [MoodInput]) {
        self.view.showLoading(false)
        self.didEndedFetchingMoodInputs = true
        self.entries.append(contentsOf: results)
        self.didEndedFetching()
    }
    
    func handleFailureFetchedMood(with message: String) {
        self.didEndedFetchingMoodInputs = true
        self.view.showLoading(false)
        self.didEndedFetching()
        self.view.showError(message: message)
    }
    
    func handleSuccessFetchedAnwsers(with results: [Answer]) {
        self.didEndedFetchingAnswers = true
        self.view.showLoading(false)
        self.entries.append(contentsOf: results)
        self.didEndedFetching()
    }
    
    func handleFailureFetchedAnwsers(with message: String) {
        self.didEndedFetchingAnswers = true
        self.view.showLoading(false)
        self.didEndedFetching()
        self.view.showError(message: message)
    }
    
    func handleSuccessAddedMood(with results: MoodInput) {
        self.entries.append(results)
        self.sortEntries()
        self.view.didAddedMood()
    }
    
    func handleFailureAddedMood(with message: String) {
        self.view.showError(message: message)
    }
    
    // MARK: - DaySummaryPresenterInputProtocol
    func loadTodayEntries() {
        self.entries = []
        self.view.didFetchEntries()
        self.view.showLoading(true)
        
        self.didEndedFetchingAnswers = false
        self.didEndedFetchingMoodInputs = false
        
        self.interactor.fetchMoods(forDate: self.currentDate)
        self.interactor.fetchAnswers(forDate: self.currentDate)
    }
    
    func loadMoodTypes() {
        self.view.showLoading(true)
        self.interactor.fetchMoodTypes()
    }
    
    func numberOfSections() -> Int {
        return 1
    }
    
    func numberOfEntries(in section: Int) -> Int {
        return self.entries.count + (self.shouldShowAddButton() ? 1 : 0)
    }
    
    func item(at indexPath: Int) -> Any {
        return self.entries[indexPath - (self.shouldShowAddButton() ? 1 : 0)]
    }
    
    func shouldShowAddButton() -> Bool {
        return Calendar.current.isDateInToday(self.currentDate)
    }
    
    func shouldDisplayLine(for index: Int) -> Bool {
        if self.entries.count == 0 {
            return self.entries.count == 0
        }
        return index + (!self.shouldShowAddButton() ? 1 : 0) == self.entries.count
    }
    
    func didTapInsert(mood index: Int) {
        self.interactor.add(moodType: self.moodTypes[index], toDate: self.currentDate)
    }
    
    func didTapInsertQuestion() {
        self.router.presentBreathingView()
    }
    
    func setCurrentDate(_ date: Date) {
        self.currentDate = date
        self.loadTodayEntries()
    }
    
    // MARK: - Private Routines
    private func didEndedFetching() {
        if self.didEndedFetchingMoodInputs && self.didEndedFetchingAnswers {
            self.sortEntries()
            self.view.didFetchEntries()
        }
    }
    
    private func sortEntries() {
        self.entries.sort(by: { entry1, entry2 in
            var date1: NSDate!
            if entry1 is MoodInput {
                date1 = (entry1 as! MoodInput).date!
            } else if entry1 is Answer {
                date1 = (entry1 as! Answer).date!
            }
            
            var date2: NSDate!
            if entry2 is MoodInput {
                date2 = (entry2 as! MoodInput).date!
            } else if entry2 is Answer {
                date2 = (entry2 as! Answer).date!
            }
            
            return (date1 as Date) > (date2 as Date)
        })
    }
    
}
