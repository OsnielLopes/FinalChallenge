//
//  UserDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 14/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import UIKit

class UserDAO {
    
    static let shared = UserDAO()

    private(set) var sampleProfilePicture: UIImage
    
    private(set) var sampleBackgroundImage: UIImage
    
    private(set) var sampleUsername: String
    
    private init() {
        self.sampleProfilePicture = UIImage(named: "user-placeholder")!
        self.sampleBackgroundImage = UIImage(named: "bg1")!
        self.sampleUsername = "User"
    }
    
    func fetch(completion: @escaping (User?, DataAccessError?) -> ()) {
        if let all = CoreDataManager.shared.fetch(User.self) {
            if let user = all.first {
                completion(user, nil)
            } else {
                completion(nil, DataAccessError(message: "User not created"))
            }
        } else {
            completion(nil, DataAccessError(message: "Error when fetching users"))
        }
    }
    
    func create(name: String? = nil, profilePicture: UIImage? = nil, backgroundImage: UIImage? = nil, completion: @escaping (User?, DataAccessError?) -> ()) {
        if let newUser = CoreDataManager.shared.create(type: User.self) {
            
            newUser.name = name
            
            if let profilePicture = profilePicture {
                newUser.set(profileIcon: profilePicture)
            }
            
            if let backgroundImage = backgroundImage {
                newUser.set(backgroundImage: backgroundImage)
            }
            
            CoreDataManager.shared.saveContext()
            
            completion(newUser, nil)
            return
        }
        completion(nil, DataAccessError(message: "Error when creating a user"))
    }
    
    func update(user: User, name: String? = nil, profilePicture: UIImage? = nil, backgroundImage: UIImage? = nil, completion: @escaping (User?, DataAccessError?) -> (Void)) {
        
        if let updatedName = name {
            user.name = updatedName
        }
        
        if let updatedProfilePicture = profilePicture {
            user.set(profileIcon: updatedProfilePicture)
        }
        
        if let updatedBackgroundImage = backgroundImage {
            user.set(backgroundImage: updatedBackgroundImage)
        }
        
        CoreDataManager.shared.saveContext()
        
        completion(user, nil)
        
    }
    
    func removeProfilePicture(of user: User, completion: @escaping (User?, DataAccessError?) -> (Void)) {
        user.set(profileIcon: self.sampleProfilePicture)
        CoreDataManager.shared.saveContext()
        completion(user, nil)
    }
    
    func removeBackgroundImage(of user: User, completion: @escaping (User?, DataAccessError?) -> (Void)) {
        user.set(backgroundImage: self.sampleBackgroundImage)
        CoreDataManager.shared.saveContext()
        completion(user, nil)
    }
    
    func delete(user: User, completion: @escaping (DataAccessError?) -> (Void)) {
        CoreDataManager.shared.delete(user)
        completion(nil)
    }
    
}
