//
//  CheckboxQuestion+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 02/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension CheckboxQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CheckboxQuestion> {
        return NSFetchRequest<CheckboxQuestion>(entityName: "CheckboxQuestion")
    }

    @NSManaged public var options: [String]?

}
