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
    
    func create(authorName: String, completion: @escaping (Author, DataAccessError) -> (Void)) {
        
        if let newAuthor = CoreDataManager.shared.create(type: Author.self) {
            
        }
        
    }
    
}
