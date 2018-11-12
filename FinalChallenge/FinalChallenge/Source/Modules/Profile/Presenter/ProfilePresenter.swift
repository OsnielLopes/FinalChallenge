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

    // MARK: - ProfilePresenterInputProtocol
    func fetchInputedEmotions(withOption option: ChartDisplayOptions) {
        self.view.showLoadInputedMoodsData(true)
        self.interactor.fetchInputedMoods(sinceDate: Calendar.current.date(byAdding: .day, value: -1 * option.rawValue, to: Date())!)
    }
    
    func fetchGuessedEmotions(sinceDate: Date) {
        fatalError()
    }
    
    func fetchMindfullnessTime(sinceDate: Date) {
        fatalError()
    }
    
    func fetchStatistics() {
        fatalError()
    }
    
    func getStatistics() -> StatisticsDTO {
        fatalError()
    }
    
    func getInputedEmotions() -> EmotionChartDTO {
        fatalError()
    }
    
    func getGuessedEmotions() -> EmotionChartDTO {
        fatalError()
    }
    
    func getMindfullnessTime() -> [MindfullnessTimeDTO] {
        fatalError()
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
    
    func handleFailureFetchedStatistics(with message: String) {
        fatalError()
    }

	// MARK: - Private Methods

}
