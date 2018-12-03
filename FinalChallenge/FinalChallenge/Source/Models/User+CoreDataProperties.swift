//
//  User+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 14/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var profileIcon: NSData?
    @NSManaged public var backgroundImage: NSData?

    func set(profileIcon: UIImage) {
        self.profileIcon = NSData(data: profileIcon.jpegData(compressionQuality: 1)!)
    }
    
    func getProfileIcon(withPlaceholder placeholder: Bool) -> UIImage? {
        guard let profileImg = self.profileIcon else {
            if placeholder {
                return UserDAO.shared.sampleProfilePicture
            }
            return nil
        }
        return UIImage(data:profileImg as Data)!
    }
    
    func set(backgroundImage: UIImage) {
        self.backgroundImage = NSData(data: backgroundImage.jpegData(compressionQuality: 1)!)
    }
    
    func getbackgroundImage(withPlaceholder placeholder: Bool) -> UIImage? {
        guard let bg = self.backgroundImage else {
            if placeholder {
                return UserDAO.shared.sampleBackgroundImage
            }
            return nil
        }
        return UIImage(data: bg as Data)!
    }
    
    func getUsername(withPlaceholder placeholder: Bool) -> String? {
        guard let username = self.name else {
            if placeholder {
                return UserDAO.shared.sampleUsername
            }
            return nil
        }
        return username
    }
    
}
