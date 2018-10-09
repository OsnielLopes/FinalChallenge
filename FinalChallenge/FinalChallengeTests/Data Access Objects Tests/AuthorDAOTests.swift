//
//  AuthorDAOTests.swift
//  FinalChallengeTests
//
//  Created by Guilherme Paciulli on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import XCTest
import CoreData

@testable import FinalChallenge

class AuthorDAOTests: XCTestCase {

    var createdAuthors: [Author]!
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "FinalChallengeDatabase", managedObjectModel: self.managedObjectModel)
        let description = NSPersistentStoreDescription()
        description.type = NSInMemoryStoreType
        description.shouldAddStoreAsynchronously = false
        
        container.persistentStoreDescriptions = [description]
        container.loadPersistentStores { (description, error) in
            precondition( description.type == NSInMemoryStoreType )
            
            if let error = error {
                fatalError("Create an in-mem coordinator failed \(error)")
            }
        }
        return container
    }()
    
    func generateData() {
        self.createdAuthors = []
        for i in 0...5 {
            let c = NSEntityDescription.insertNewObject(forEntityName: "Author", into: self.mockPersistantContainer.viewContext) as! Author
            c.name = "Author\(i)"
            self.createdAuthors.append(c)
        }
        try! self.mockPersistantContainer.viewContext.save()
    }
    
    func flushData() {
        self.createdAuthors = []
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Author")
        let all = try! self.mockPersistantContainer.viewContext.fetch(request) as! [Author]
        for i in all {
            self.mockPersistantContainer.viewContext.delete(i)
        }
        
        try! self.mockPersistantContainer.viewContext.save()
    }
    
    override func setUp() {
        super.setUp()
        self.generateData()
        CoreDataManager.shared.persistentContainer = self.mockPersistantContainer
    }

    override func tearDown() {
        self.flushData()
        super.tearDown()
    }

    func testIfCreatesAnAuthor() {
        AuthorDAO.shared.create(authorName: "User", completion: { (author, err) in
            XCTAssertNil(err)
            XCTAssertNotNil(author)
        })
    }
    
    func testIfFetchesAuthors() {
        AuthorDAO.shared.fetchAll(completion: { (authors, err) in
            XCTAssertNil(err)
            XCTAssertNotNil(authors)
            XCTAssert(authors!.count == 6)
        })
    }
    
    func testIfUpdatesAnAuthor() {
        AuthorDAO.shared.update(author: self.createdAuthors[0], name: "Other user", completion: { (author, err) in
            XCTAssertNil(err)
            XCTAssertNotNil(author)
            XCTAssertEqual(author!.name, "Other user")
        })
    }
    
    func testIfDeletesAnAuthor() {
        AuthorDAO.shared.delete(author: self.createdAuthors[0], completion: { err in
            XCTAssertNil(err)
        })
    }

}
