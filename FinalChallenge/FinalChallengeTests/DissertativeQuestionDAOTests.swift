//
//  DissertativeQuestionDAO.swift
//  FinalChallengeTests
//
//  Created by Guilherme Paciulli on 05/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import XCTest
import CoreData

@testable import FinalChallenge

class DissertativeQuestionDAOTests: XCTestCase {
    
    var createdDissertationQuestions: [DissertationQuestion]!
    
    var category: Category!
    
    var author: Author!
    
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
        let auth = NSEntityDescription.insertNewObject(forEntityName: "Author", into: CoreDataManager.shared.persistentContainer.viewContext) as! Author
        auth.name = "System"
        self.author = auth
        
        let cat = NSEntityDescription.insertNewObject(forEntityName: "Category", into: CoreDataManager.shared.persistentContainer.viewContext) as! Category
        cat.name = "Família"
        self.category = cat

        self.createdDissertationQuestions = []
        for i in 0...5 {
            let c = NSEntityDescription.insertNewObject(forEntityName: "DissertationQuestion", into: self.mockPersistantContainer.viewContext) as! DissertationQuestion
            c.category = cat
            c.questionAuthor = auth
            c.questionText = "How are you? \(i)"
        
            self.createdDissertationQuestions.append(c)
        }

        cat.addToQuestions(NSSet.init(array: self.createdDissertationQuestions))
        auth.addToCreatedQuestions(NSSet.init(array: self.createdDissertationQuestions))
        
        CoreDataManager.shared.saveContext()
    }
    
    func flushData() {
        self.createdDissertationQuestions = []
        let all = try! CoreDataManager.shared.persistentContainer.viewContext.fetch(DissertationQuestion.fetchRequest()) as! [DissertationQuestion]
        for i in all {
            CoreDataManager.shared.persistentContainer.viewContext.delete(i)
        }
        CoreDataManager.shared.persistentContainer.viewContext.delete(self.category)
        CoreDataManager.shared.persistentContainer.viewContext.delete(self.author)
        
        self.category = nil
        self.author = nil
        CoreDataManager.shared.saveContext()
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
    
    func testIfCreatesDissertationQuestion() {
        DissertativeQuestionDAO.shared.create(questionText: "Como você vai?", category: self.category, author: self.author, completion: {dissertationQuestion, err in
            XCTAssertNil(err)
            XCTAssertNotNil(dissertationQuestion)
        })
    }
    
    func testIfFetchesCategries() {
        DissertativeQuestionDAO.shared.fetchAll(completion: { dissertativeQuestions, err in
            XCTAssertNil(err)
            XCTAssertNotNil(dissertativeQuestions)
            XCTAssert(dissertativeQuestions!.count == 6)
        })
    }
    
    func testIfDeletesCategory() {
        DissertativeQuestionDAO.shared.delete(question: self.createdDissertationQuestions[0], completion: { err in
            XCTAssertNil(err)
        })
    }
    
    func testIfUpdatesCategory() {
        DissertativeQuestionDAO.shared.update(question: self.createdDissertationQuestions[0], questionText: "Como você foi?", completion: { question, err in
            XCTAssertNil(err)
            XCTAssertNotNil(question)
            XCTAssertEqual(self.createdDissertationQuestions[0].questionText, question!.questionText)
        })
    }
    
}
