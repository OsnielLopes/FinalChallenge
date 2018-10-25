//
//  DaySummaryInteractor.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 24/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class DaySummaryInteractor: NSObject, DaySummaryInteractorInputProtocol {
    
    // MARK: - Properties
    private var moodTypes: [MoodType] = []
    private var answers: [Answer] = []
    private var moodInputs: [MoodInput] = []
    
    // MARK: - Viper Module Properties
    weak var output: DaySummaryInteractorOutputProtocol!

    // MARK: - DaySummaryInteractorInputProtocol
    func fetchMoodTypes() {
        MoodDAO.shared.fetchMoodTypes(completion: { moodTypes, err in
            guard let moodTypes = moodTypes, err == nil else {
                self.output.handleFailureFetchedMoodTypes(with: "There was a problem fetching the MoodTypes")
                return
            }
            self.moodTypes = moodTypes
            self.output.handleSuccessFetchedMoodTypes(with: moodTypes)
        })
    }
    
    func fetchMoods(forDate date: Date) {
        MoodDAO.shared.fetchByDay(date, completion: { moods, err in
            guard let moodInputs = moods, err == nil else {
                self.output.handleFailureFetchedMood(with: "There was a problem fetching the moods for this date")
                return
            }
            self.moodInputs = moodInputs
            self.output.handleSuccessFetchedMood(with: self.moodInputs)
        })
    }
    
    func fetchAnswers(forDate date: Date) {
        AnswerDAO.shared.fetchByDay(date, completion: { answers, err in
            guard let answers = answers, err == nil else {
                self.output.handleFailureFetchedAnwsers(with: "There was a problem fetching the answers for this date")
                return
            }
            self.answers = answers
            self.output.handleSuccessFetchedAnwsers(with: self.answers)
        })
    }
    
}
