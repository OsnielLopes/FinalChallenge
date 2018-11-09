//
//  QuestionsDAOTests.swift
//  FinalChallengeTests
//
//  Created by Guilherme Paciulli on 08/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import XCTest
import CoreData

@testable import FinalChallenge

class QuestionsDAOTests: XCTestCase {
    
    var questions: [Question]!
    
    var category: FinalChallenge.Category!
    
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
        let auth = NSEntityDescription.insertNewObject(forEntityName: "Author", into: self.mockPersistantContainer.viewContext) as! Author
        auth.name = "System"
        self.author = auth
        
        let cat = NSEntityDescription.insertNewObject(forEntityName: "Category", into: self.mockPersistantContainer.viewContext) as! FinalChallenge.Category
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
        
        for i in 0...5 {
            let c = NSEntityDescription.insertNewObject(forEntityName: "DissertationQuestion", into: self.mockPersistantContainer.viewContext) as! DissertationQuestion
            c.category = cat
            c.questionAuthor = auth
            c.questionText = "How are you? \(i)"
            
            self.questions.append(c)
        }
        
        cat.addToQuestions(NSSet.init(array: self.questions))
        auth.addToCreatedQuestions(NSSet.init(array: self.questions))
        
        try! self.mockPersistantContainer.viewContext.save()
    }
    
    func flushData() {
        self.questions = []
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Question")
        let all = try! self.mockPersistantContainer.viewContext.fetch(request) as! [Question]
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

    func testIfFetchesAllQuestions() {
        QuestionDAO.shared.fetchAll(completion: { (questions, err) in
            XCTAssertNil(err)
            XCTAssertNotNil(questions)
            XCTAssertEqual(self.questions.count, questions!.count)
        })
    }
    
    func testsIfDeletesQuestion() {
        QuestionDAO.shared.delete(question: self.questions[0], completion: { err in
            XCTAssertNil(err)
        })
    }


}
