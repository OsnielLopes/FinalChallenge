//
//  OnboardingInteractor.swift
//  FinalChallenge
//
//  Created Guilherme Paciulli on 21/11/18.
//  Copyright © 2018. All rights reserved.
//

import UIKit

class OnboardingInteractor: NSObject, OnboardingInteractorInputProtocol {

	// MARK: - Viper Module Properties
    weak var output: OnboardingInteractorOutputProtocol!
    
    // MARK: - Properties
    var user: User!

	// MARK: - OnboardingInteractorInputProtocol
    
    func createUserIfNecessary() {
        UserDAO.shared.fetch(completion: { user, err in
            if let user = user {
                self.user = user
                self.output.handleSuccessUpdatedUser(with: self.user)
            } else if err?.message == "User not created" {
                UserDAO.shared.create(completion: { user, err in
                    guard let user = user, err == nil else {
                        self.output.handleFailureCreatedUser(with: "There was an error creating the user")
                        return
                    }
                    self.user = user
                    self.output.handleSuccessCreatedUser(with: self.user)
                })
            } else {
                self.output.handleFailureCreatedUser(with: "There was an error fetching the user")
            }
        })
    }
    
    func setUserAvatar(_ image: UIImage?) {
        UserDAO.shared.update(user: self.user, profilePicture: image, completion: { user, err in
            guard let user = user, err == nil else {
                self.output.handleFailureUpdatedUser(with: "There was an error setting the user's avatar")
                return
            }
            self.user = user
            self.output.handleSuccessUpdatedUser(with: self.user)
        })
    }
    
    func setUserCover(_ image: UIImage?) {
        UserDAO.shared.update(user: self.user, backgroundImage: image, completion: { user, err in
            guard let user = user, err == nil else {
                self.output.handleFailureUpdatedUser(with: "There was an error setting the user's background picture")
                return
            }
            self.user = user
            self.output.handleSuccessUpdatedUser(with: self.user)
        })
    }
    
    func setUserName(_ name: String?) {
        UserDAO.shared.update(user: self.user, name: name, completion: { user, err in
            guard let user = user, err == nil else {
                self.output.handleFailureUpdatedUser(with: "There was an error setting the user's name")
                return
            }
            self.user = user
            self.output.handleSuccessUpdatedUser(with: self.user)
        })
    }

    // MARK: - Private Methods

}
