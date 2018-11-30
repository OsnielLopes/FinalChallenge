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
    
    func getProfileIcon() -> UIImage? {
        guard let profileImg = self.profileIcon else {
            return nil
        }
        return UIImage(data:profileImg as Data)!
    }
    
    func set(backgroundImage: UIImage) {
        self.backgroundImage = NSData(data: backgroundImage.jpegData(compressionQuality: 1)!)
    }
    
    func getbackgroundImage() -> UIImage? {
        guard let bg = self.backgroundImage else {
            return nil
        }
        return UIImage(data: bg as Data)!
    }
    
}
