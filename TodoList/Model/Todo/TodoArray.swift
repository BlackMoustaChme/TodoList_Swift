//
//  TodoArray.swift
//  TodoList
//
//  Created by Michael Chernousov on 12.02.2024.
//

import Foundation

struct TodoArray: Codable {
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    let items: [Todo]
}
