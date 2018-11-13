//
//  User+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 13/11/18.
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
    
    func set(image: UIImage) {
        self.profileIcon = NSData(data: image.jpegData(compressionQuality: 1)!)
    }
    
    func getImage() -> UIImage {
        return UIImage(data: self.profileIcon! as Data)!
    }

}
