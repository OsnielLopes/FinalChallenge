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
    private var answers: [Answer] = []
    private var moodTypes: [MoodType] = []
    private var moods: [MoodInput] = []
    
    // MARK: - Viper Module Properties
    weak var view: DaySummaryPresenterOutputProtocol!
    var interactor: DaySummaryInteractorInputProtocol!
    var router: DaySummaryRouterProtocol!
    
    
    // MARK: - DaySummaryInteractorOutputProtocol
    func handleSuccessFetchedMoodTypes(with results: [MoodType]) {
        self.moodTypes = results
    }
    
    func handleFailureFetchedMoodTypes(with message: String) {
    }
    
    func handleSuccessFetchedMood(with results: [MoodInput]) {
    }
    
    func handleFailureFetchedMood(with message: String) {
    }
    
    func handleSuccessFetchedAnwsers(with results: [Answer]) {
    }
    
    func handleFailureFetchedAnwsers(with message: String) {
    }
    
    // MARK: - DaySummaryPresenterInputProtocol
    func loadTodayEntries() {
    }
    
    func numberOfSections() -> Int {
    }
    
    func numberOfEntries(in section: Int) -> Int {
    }
    
    func item(at indexPath: Int) -> Any {
    }
    
    func didTapInsert(mood index: Int) {
    }
    
    func didTapInsertQuestion() {
    }
    
    
}
