//
//  Todo.swift
//  TodoList
//
//  Created by Michael Chernousov on 12.02.2024.
//

import Foundation

struct Todo: Codable {
    
    var id: Int
    var title: String
    var creationDate: String
    var text: String
    var check: Bool
    
}
