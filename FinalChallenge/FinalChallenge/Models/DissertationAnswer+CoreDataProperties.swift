//
//  DissertationAnswer+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 02/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension DissertationAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DissertationAnswer> {
        return NSFetchRequest<DissertationAnswer>(entityName: "DissertationAnswer")
    }

    @NSManaged public var text: String?

}
