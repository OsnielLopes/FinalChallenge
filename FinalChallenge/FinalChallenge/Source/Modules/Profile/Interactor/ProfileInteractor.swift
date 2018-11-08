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
    var inputedMoods: [MoodInput] = []

	// MARK: - ProfileInteractorInputProtocol
    func fetchInputedMoods(sinceDate date: Date) {
        fatalError()
    }
    
    func fetchGuessedMoods(sinceDate date: Date) {
        fatalError()
    }
    
    func fetchMindfullnessTime(sinceDate date: Date) {
        fatalError()
    }
    
    func fetchStatistics() {
        fatalError()
    }

    // MARK: - Private Methods

}
