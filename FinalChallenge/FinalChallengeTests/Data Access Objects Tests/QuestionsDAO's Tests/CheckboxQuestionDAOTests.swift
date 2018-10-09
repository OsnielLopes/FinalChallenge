//
//  CheckboxQuestionDAOTests.swift
//  FinalChallengeTests
//
//  Created by Guilherme Paciulli on 08/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import XCTest
import CoreData

@testable import FinalChallenge

class CheckboxQuestionDAOTests: XCTestCase {
    
    var category: Category!
    
    var author: Author!
    
    var questions: [CheckboxQuestion]!
    
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
        let auth = NSEntityDescription.insertNewObject(forEntityName: "Author", into: self.mockPersistantContainer.viewContext) as! Author
        auth.name = "System"
        self.author = auth
        
        let cat = NSEntityDescription.insertNewObject(forEntityName: "Category", into: self.mockPersistantContainer.viewContext) as! Category
        cat.name = "Família"
        self.category = cat
        
        self.questions = []
        for i in 0...5 {
            let c = NSEntityDescription.insertNewObject(forEntityName: "CheckboxQuestion", into: self.mockPersistantContainer.viewContext) as! CheckboxQuestion
            c.category = cat
            c.questionAuthor = auth
            c.questionText = "How are you? \(i)"
            c.options = ["Good", "Bad"]
            
            self.questions.append(c)
        }
        
        cat.addToQuestions(NSSet.init(array: self.questions))
        auth.addToCreatedQuestions(NSSet.init(array: self.questions))
        
        try! self.mockPersistantContainer.viewContext.save()
    }
    
    func flushData() {
        self.questions = []
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "CheckboxQuestion")
        let all = try! self.mockPersistantContainer.viewContext.fetch(request) as! [CheckboxQuestion]
        for i in all {
            self.mockPersistantContainer.viewContext.delete(i)
        }
        self.mockPersistantContainer.viewContext.delete(self.category)
        self.mockPersistantContainer.viewContext.delete(self.author)
        
        self.category = nil
        self.author = nil
        
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

    func testIfCreatesCheckboxQuestion() {
        CheckboxQuestionDAO.shared.create(questionText: "How are you?", category: self.category, author: self.author, options: ["Good", "Bad"], completion: { question, err in
            XCTAssertNil(err)
            XCTAssertNotNil(question)
        })
    }
    
    func testIfFetchesAllCheckboxQuestions() {
        CheckboxQuestionDAO.shared.fetchAll(completion: { questions, err in
            XCTAssertNil(err)
            XCTAssertNotNil(questions)
            XCTAssert(questions!.count == 6)
        })
    }
    
    func testIfUpdatesCheckboxQuestion() {
        CheckboxQuestionDAO.shared.update(question: self.questions[0], options: ["Only good"], completion: { (question, err) in
            XCTAssertNil(err)
            XCTAssertNotNil(question)
            XCTAssert(self.questions![0].options![0] == "Only good")
        })
    }
}
