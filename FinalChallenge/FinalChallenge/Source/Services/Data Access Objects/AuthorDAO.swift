//
//  AuthorDAO.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 09/10/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation

class AuthorDAO {
    
    static let shared = AuthorDAO()
    
    private init() { }
    
    func fetchAll(completion: @escaping ([Author]?, DataAccessError?) -> (Void)) {
        
        if let allAuthors = CoreDataManager.shared.fetch(Author.self) {
            completion(allAuthors, nil)
        } else {
            completion(nil, DataAccessError(message: "Error when fetching all authors"))
        }
    }
    
    func create(authorName: String, completion: @escaping (Author?, DataAccessError?) -> (Void)) {
        
        if let newAuthor = CoreDataManager.shared.create(type: Author.self) {
            newAuthor.name = authorName
            
            completion(newAuthor, nil)
        } else {
            completion(nil, DataAccessError(message: "There was a problem creating an author"))
        }
        
    }
    
    func update(author: Author, name: String? = nil, completion: @escaping (Author?, DataAccessError?) -> (Void)) {
        
        if let updatedName = name {
            author.name = updatedName
        }
        
        CoreDataManager.shared.saveContext()
        
        completion(author, nil)
        
    }
    
    func delete(author: Author, completion: @escaping (DataAccessError?) -> (Void)) {
        CoreDataManager.shared.delete(author)
        completion(nil)
    }
    
}
