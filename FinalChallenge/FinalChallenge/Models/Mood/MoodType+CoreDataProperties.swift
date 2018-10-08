//
//  MoodType+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 08/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension MoodType {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MoodType> {
        return NSFetchRequest<MoodType>(entityName: "MoodType")
    }

    @NSManaged public var typeIcon: String?
    @NSManaged public var typeText: String?
    @NSManaged public var insertedMoods: NSSet?

}

// MARK: Generated accessors for insertedMoods
extension MoodType {

    @objc(addInsertedMoodsObject:)
    @NSManaged public func addToInsertedMoods(_ value: MoodInput)

    @objc(removeInsertedMoodsObject:)
    @NSManaged public func removeFromInsertedMoods(_ value: MoodInput)

    @objc(addInsertedMoods:)
    @NSManaged public func addToInsertedMoods(_ values: NSSet)

    @objc(removeInsertedMoods:)
    @NSManaged public func removeFromInsertedMoods(_ values: NSSet)

}
