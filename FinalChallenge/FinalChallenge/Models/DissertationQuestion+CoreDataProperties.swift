//
//  DissertationQuestion+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 02/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension DissertationQuestion {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DissertationQuestion> {
        return NSFetchRequest<DissertationQuestion>(entityName: "DissertationQuestion")
    }


}
