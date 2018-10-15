//
//  MoodInput+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 08/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension MoodInput {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoodInput> {
        return NSFetchRequest<MoodInput>(entityName: "MoodInput")
    }

    @NSManaged public var date: NSDate?
    @NSManaged public var moodType: MoodType?

}
