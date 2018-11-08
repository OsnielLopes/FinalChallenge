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
    func fetchInputedEmotions(sinceDate: Date)
    func fetchGuessedEmotions(sinceDate: Date)
    func fetchMindfullnessTime(sinceDate: Date)
    func fetchStatistics()
    
    // MARK: Getters
    func getStatistics() -> StatisticsDTO
    func getInputedEmotions() -> [EmotionChartViewObject]
    func getGuessedEmotions() -> [EmotionChartViewObject]
    func getMindfullnessTime() -> [MindfullnessTimeDTO]
}

protocol ProfileInteractorOutputProtocol: class {
    func handleSuccessFetchedInputedMood(with results: [MoodInput])
    func handleFailureFetchedInputedMood(with message: String)
    
    func handleSuccessFetchedGuessedMood(with results: [MoodInput])
    func handleFailureFetchedGuessedMood(with message: String)
    
    func handleSuccessFetchedMindfullnessTime(with results: MindfullnessTimeDTO)
    func handleFailureFetchedMindfullnessTime(with message: String)
    
    func handleSuccessFetchedStatistics(with results: StatisticsDTO)
    func handleFailureFetchedStatistics(with message: String)
}

// MARK: - View
protocol ProfilePresenterOutputProtocol: class {
    func loadInputedMoodsData()
    func loadGuessedEmotions()
    func loadMindfullnessTime()
    func loadStatistics()
}
