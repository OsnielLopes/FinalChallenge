//
//  CategoryDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 05/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import CoreData

class CategoryDAO {
    
    static let shared = CategoryDAO()
    
    private init() { }
    
    func fetchAll(completion: @escaping ([Category]?, DataAccessError?) -> (Void)) {
        
        if let allCategories = CoreDataManager.shared.fetch(Category.self) as? [Category] {
            completion(allCategories, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all categories"))
        }
        
    }
    
    func create(name: String, completion: @escaping (Category?, DataAccessError?) -> (Void)) {
        
        if let newCategory = CoreDataManager.shared.create(type: Category.self) as? Category {

            newCategory.name = name
            newCategory.questions = NSSet(array: [])
            
            CoreDataManager.shared.saveContext()
            
            completion(newCategory, nil)
            return
        }
        completion(nil, DataAccessError(message: "Error when creating a category"))
        
    }
    
    func update(category: Category, name: String? = nil, questions: [Question]? = nil, completion: @escaping (Category?, DataAccessError?) -> (Void)) {
        
        if let updatedName = name {
            category.name = updatedName
        }
        
        if let updatedQuestions = questions {
            category.questions = NSSet(array: updatedQuestions)
        }
        
        CoreDataManager.shared.saveContext()
        
        completion(category, nil)
        
    }
    
    func delete(category: Category, completion: @escaping (DataAccessError?) -> (Void)) {
        CoreDataManager.shared.delete(category)
        completion(nil)
    }
    
}
