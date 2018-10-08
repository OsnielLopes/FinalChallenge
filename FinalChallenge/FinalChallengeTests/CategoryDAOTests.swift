//
//  CategoryDAOTests.swift
//  FinalChallengeTests
//
//  Created by Guilherme Paciulli on 05/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import XCTest
import CoreData

class CategoryDAOTests: XCTestCase {
    
    var createdCategories: [Category]!
    
    lazy var managedObjectModel: NSManagedObjectModel = {
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle(for: type(of: self))] )!
        return managedObjectModel
    }()
    
    lazy var mockPersistantContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "PersistentTodoList", managedObjectModel: self.managedObjectModel)
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
        self.createdCategories = []
        for i in 0...5 {
            let c = NSEntityDescription.insertNewObject(forEntityName: "Category", into: CoreDataManager.shared.persistentContainer.viewContext) as! Category
            c.name = "Category\(i)"
            c.questions = NSSet(array: [])
            self.createdCategories.append(c)
        }
        CoreDataManager.shared.saveContext()
    }
    
    func flushData() {
        self.createdCategories = []
        let all = try! CoreDataManager.shared.persistentContainer.viewContext.fetch(Category.fetchRequest()) as! [Category]
        for i in all {
            CoreDataManager.shared.persistentContainer.viewContext.delete(i)
        }
        CoreDataManager.shared.saveContext()
    }
    
    override func setUp() {
        super.setUp()
        CoreDataManager.shared.persistentContainer = self.mockPersistantContainer
        self.generateData()
    }

    override func tearDown() {
        self.flushData()
        super.tearDown()
    }

    func testIfCreatesCategory() {
        CategoryDAO.shared.create(name: "Família", completion: { category, err in
            XCTAssertNil(err)
            XCTAssertNotNil(category)
        })
    }
    
    func testIfFetchesCategries() {
        CategoryDAO.shared.fetchAll(completion: { categories, err in
            XCTAssertNil(err)
            XCTAssertNotNil(categories)
            XCTAssert(categories!.count == 6)
        })
    }
    
    func testIfDeletesCategory() {
        CategoryDAO.shared.delete(category: self.createdCategories[0], completion: {err in
            XCTAssertNil(err)
        })
    }
    
    func testIfUpdatesCategory() {
        CategoryDAO.shared.update(category: self.createdCategories[0], name: "Relacionamento", completion: { category, err in
            XCTAssertNil(err)
            XCTAssertNotNil(category)
            XCTAssertEqual(self.createdCategories[0].name, "Relacionamento")
        })
    }

}
