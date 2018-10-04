//
//  CheckboxAnswer+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 02/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension CheckboxAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CheckboxAnswer> {
        return NSFetchRequest<CheckboxAnswer>(entityName: "CheckboxAnswer")
    }

    @NSManaged public var options: [Int]?

}
