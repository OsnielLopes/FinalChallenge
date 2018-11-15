//
//  ProfilePresenter.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 07/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class ProfilePresenter: NSObject, ProfilePresenterInputProtocol, ProfileInteractorOutputProtocol {

	// MARK: - Viper Module Properties
    weak var view: ProfilePresenterOutputProtocol!
    var interactor: ProfileInteractorInputProtocol!
    var router: ProfileRouterProtocol!
    
    // MARK: - Properties
    var inputedMoodEmotionChartDTO: EmotionChartDTO?
    var guessedMoodEmotionChartDTO: EmotionChartDTO?
    var statistics: StatisticsDTO?

    // MARK: - ProfilePresenterInputProtocol
    func fetchInputedEmotions(withOption option: ChartDisplayOptions) {
        self.view.showLoadInputedMoodsData(true)
        let date = Calendar.current.date(byAdding: .day, value: -1 * option.rawValue, to: Date())!
        self.interactor.fetchInputedMoods(sinceDate: date)
    }
    
    func fetchGuessedEmotions(sinceDate: Date) {
        fatalError()
    }
    
    func fetchMindfullnessTime(sinceDate: Date) {
        fatalError()
    }
    
    func fetchStatistics() {
        self.interactor.fetchStatistics()
    }

    // MARK: - ProfilePresenterInteractorOutputProtocol
    func handleSuccessFetchedInputedMood(with results: EmotionChartDTO) {
        self.view.showLoadInputedMoodsData(false)
        self.inputedMoodEmotionChartDTO = results
        self.view.didFetchInputedMoodsData(results)
    }
    
    func handleFailureFetchedInputedMood(with message: String) {
        self.view.showLoadInputedMoodsData(false)
        self.inputedMoodEmotionChartDTO = nil
        self.view.showError(message: message)
    }
    
    func handleSuccessFetchedGuessedMood(with results: EmotionChartDTO) {
        self.view.showLoadGuessedEmotions(false)
        self.guessedMoodEmotionChartDTO = results
        self.view.didFetchGuessedEmotions(results)
    }
    
    func handleFailureFetchedGuessedMood(with message: String) {
        self.view.showLoadGuessedEmotions(false)
        self.guessedMoodEmotionChartDTO = nil
        self.view.showError(message: message)
    }
    
    func handleSuccessFetchedMindfullnessTime(with results: MindfullnessTimeDTO) {
        fatalError()
    }
    
    func handleFailureFetchedMindfullnessTime(with message: String) {
        fatalError()
    }
    
    func handleSuccessFetchedStatistics(with results: StatisticsDTO) {
        fatalError()
    }
    
    func handleFailureFetchedStatistics(with message: [String]) {
        self.view.showLoadStatistics(false)
        self.statistics = nil
    }

	// MARK: - Private Methods

}
