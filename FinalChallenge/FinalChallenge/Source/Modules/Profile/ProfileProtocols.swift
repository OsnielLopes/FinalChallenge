//
//  ProfileProtocols.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 07/11/18.
//  Copyright © 2018. All rights reserved.
//

import Foundation
import UIKit

// MARK: - Router
protocol ProfileRouterProtocol: class {

}

// MARK: - Interactor
protocol ProfileInteractorInputProtocol {
    
    func fetchInputedMoods(sinceDate date: Date)
    func fetchGuessedMoods(sinceDate date: Date)
    func fetchMindfullnessTime(sinceDate date: Date)
    func fetchStatistics()
    
}

// MARK: - Presenter
protocol ProfilePresenterInputProtocol: class {
    
    // MARK: - Fetches
    func fetchInputedEmotions(withOption option: ChartDisplayOptions)
    func fetchGuessedEmotions(sinceDate: Date)
    func fetchMindfullnessTime(sinceDate: Date)
    func fetchStatistics()
    
    // MARK: Getters
    func getStatistics() -> StatisticsDTO
    func getInputedEmotions() -> EmotionChartDTO
    func getGuessedEmotions() -> EmotionChartDTO
    func getMindfullnessTime() -> [MindfullnessTimeDTO]
}

protocol ProfileInteractorOutputProtocol: class {
    func handleSuccessFetchedInputedMood(with results: EmotionChartDTO)
    func handleFailureFetchedInputedMood(with message: String)
    
    func handleSuccessFetchedGuessedMood(with results: EmotionChartDTO)
    func handleFailureFetchedGuessedMood(with message: String)
    
    func handleSuccessFetchedMindfullnessTime(with results: MindfullnessTimeDTO)
    func handleFailureFetchedMindfullnessTime(with message: String)
    
    func handleSuccessFetchedStatistics(with results: StatisticsDTO)
    func handleFailureFetchedStatistics(with message: [String])
}

// MARK: - View
protocol ProfilePresenterOutputProtocol: class {
    func showError(message: String)
    func showErrors(message: [String])
    
    func showLoadInputedMoodsData(_ loading: Bool)
    func showLoadGuessedEmotions(_ loading: Bool)
    func showLoadMindfullnessTime(_ loading: Bool)
    func showLoadStatistics(_ loading: Bool)
    
    func didFetchInputedMoodsData(_ results: EmotionChartDTO)
    func didFetchGuessedEmotions(_ results: EmotionChartDTO)
    func didFetchMindfullnessTime(_ results: MindfullnessTimeDTO)
    func didFetchStatistics(_ results: StatisticsDTO)
}
