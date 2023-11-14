//
//  Fetchable.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation

// MARK: - Todo Protocol for GET , PUT, POST, DELETE.

protocol Fetchable {
    
    func get(url: URL) async throws -> Data
    func post(todo: String, isCompleted: Bool, userID: Int) async throws -> Data
    func put(isCompleted: Bool, id: Int) async throws -> Data
    func delete(id: Int) async throws -> Data
}
