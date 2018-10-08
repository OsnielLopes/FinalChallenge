//
//  RadioboxAnswer+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 08/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension RadioboxAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RadioboxAnswer> {
        return NSFetchRequest<RadioboxAnswer>(entityName: "RadioboxAnswer")
    }

    @NSManaged public var option: Int32

}
