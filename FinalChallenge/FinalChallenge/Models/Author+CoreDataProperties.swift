//
//  Author+CoreDataProperties.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 02/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//
//

import Foundation
import CoreData


extension Author {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Author> {
        return NSFetchRequest<Author>(entityName: "Author")
    }

    @NSManaged public var name: String?
    @NSManaged public var createdQuestions: NSSet?

}

// MARK: Generated accessors for createdQuestions
extension Author {

    @objc(addCreatedQuestionsObject:)
    @NSManaged public func addToCreatedQuestions(_ value: Question)

    @objc(removeCreatedQuestionsObject:)
    @NSManaged public func removeFromCreatedQuestions(_ value: Question)

    @objc(addCreatedQuestions:)
    @NSManaged public func addToCreatedQuestions(_ values: NSSet)

    @objc(removeCreatedQuestions:)
    @NSManaged public func removeFromCreatedQuestions(_ values: NSSet)

}
