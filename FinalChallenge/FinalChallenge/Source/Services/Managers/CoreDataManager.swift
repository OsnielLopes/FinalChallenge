//
//  DatabaseManager.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 02/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    
    static let shared = CoreDataManager()
        
    private init() { }
    
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FinalChallengeDatabase")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = CoreDataManager.shared.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetch<T: NSManagedObject>(_ fetchRequest: T.Type) -> [T]? {
        do {
            let entityName = String(describing: T.self)
            let request = NSFetchRequest<T>(entityName: entityName)
            return try self.persistentContainer.viewContext.fetch(request)
        } catch {
            print("There was and error fetching " + String(describing: T.self))
        }
        return nil
    }
    
    func create<T: NSManagedObject>(type: T.Type) -> T? {
        let className = String(describing: T.self)
        return NSEntityDescription.insertNewObject(forEntityName: className, into: CoreDataManager.shared.persistentContainer.viewContext) as? T
    }
    
    func delete(_ entity: NSManagedObject) {
        self.persistentContainer.viewContext.delete(entity)
        self.saveContext()
    }
    
}
