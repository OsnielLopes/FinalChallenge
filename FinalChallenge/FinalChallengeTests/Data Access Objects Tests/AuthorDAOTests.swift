//
//  AuthorDAOTests.swift
//  FinalChallengeTests
//
//  Created by Guilherme Paciulli on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import XCTest
import CoreData

class AuthorDAOTests: XCTestCase {

    var createdAuthor: [Author]!
    
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
    }
    
    func flushData() {
    }
    
    override func setUp() {
        super.setUp()
        self.generateData()
    }

    override func tearDown() {
        self.flushData()
        super.setUp()
    }

    func testIfCreatesAnAuthor() {
    }
    
    func testIfFetchesAuthors() {
    }
    
    func testIfUpdatesAuthor() {
    }
    
    func testIfDeletesAuthor() {
    }

}
