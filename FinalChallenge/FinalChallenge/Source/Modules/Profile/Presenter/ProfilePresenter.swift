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

    // MARK: - ProfilePresenterInputProtocol
    func fetchInputedEmotions(sinceDate: Date) {
        self.interactor.fetchInputedMoods(sinceDate: sinceDate)
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
        fatalError()
    }
    
    func handleFailureFetchedInputedMood(with message: String) {
        fatalError()
    }
    
    func handleSuccessFetchedGuessedMood(with results: EmotionChartDTO) {
        fatalError()
    }
    
    func handleFailureFetchedGuessedMood(with message: String) {
        fatalError()
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
