//
//  ProfileInteractor.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 07/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class ProfileInteractor: NSObject, ProfileInteractorInputProtocol {

	// MARK: - Viper Module Properties
    weak var output: ProfileInteractorOutputProtocol!
    
    // MARK: - Properties
    var inputedMoodChartData: EmotionChartDTO?

	// MARK: - ProfileInteractorInputProtocol
    func fetchInputedMoods(sinceDate date: Date) {
        var types: [MoodType] = []
        var moods: [MoodInput] = []
        var didFinishFetchingTypes = false
        var didFinishFetchingMoods = false
        
        let didFinishFetching = {
            if didFinishFetchingMoods && didFinishFetchingTypes {
                self.inputedMoodChartData = EmotionChartDTO(chartTitle: "Inputed Moods", moods: moods, possible: types)
                self.output.handleSuccessFetchedInputedMood(with: self.inputedMoodChartData!)
            }
        }
        
        MoodDAO.shared.fetchSinceDay(date, completion: { fetchedMoods, err in
            guard let moodInputs = fetchedMoods, err == nil else {
                self.output.handleFailureFetchedInputedMood(with: "There was a problem fetching the inputed moods since this date")
                return
            }
            moods = moodInputs
            didFinishFetchingMoods = true
            didFinishFetching()
        })
        MoodDAO.shared.fetchMoodTypes(completion: { fetchedTypes, err in
            guard let moodTypes = fetchedTypes, err == nil else {
                self.output.handleFailureFetchedInputedMood(with: "There was a problem fetching the mood types")
                return
            }
            types = moodTypes
            didFinishFetchingTypes = true
            didFinishFetching()           
        })
    }
    
    func fetchGuessedMoods(sinceDate date: Date) {
        fatalError()
    }
    
    func fetchMindfullnessTime(sinceDate date: Date) {
        fatalError()
    }
    
    func fetchStatistics() {
        StatisticsFactory.shared.generateStatistics(completion: { fetchedStats, error in
            guard let stats = fetchedStats, error == nil else {
                self.output.handleFailureFetchedStatistics(with: error!.map({ $0.message }))
                return
            }
            self.output.handleSuccessFetchedStatistics(with: stats)
        })
    }

    // MARK: - Private Methods

}
