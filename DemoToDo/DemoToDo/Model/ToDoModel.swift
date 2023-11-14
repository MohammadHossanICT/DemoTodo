//
//  ToDoModel.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation

// MARK: - Welcome
struct ToDoModel: Decodable, Hashable {
    let todos: [Todo]
}

// MARK: - Todo
struct Todo: Decodable, Hashable {
    let id: Int
    let todo: String
    let completed: Bool
    let userID: Int
    
    enum CodingKeys: String, CodingKey {
        case id, todo, completed
        case userID = "userId"
    }
}
