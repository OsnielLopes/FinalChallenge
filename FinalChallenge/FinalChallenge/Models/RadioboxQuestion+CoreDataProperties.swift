//
//  RadioboxQuestion+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 02/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension RadioboxQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RadioboxQuestion> {
        return NSFetchRequest<RadioboxQuestion>(entityName: "RadioboxQuestion")
    }

    @NSManaged public var options: [String]?

}
