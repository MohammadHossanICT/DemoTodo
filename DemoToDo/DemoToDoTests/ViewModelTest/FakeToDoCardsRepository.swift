//
//  FakeToDoCardsRepository.swift
//  DemoToDoTests
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation
@testable import DemoToDo

class FakeToDoCardsRepository: ToDoCardsRepository {
    func addToDoList(todo: String, isCompleted: Bool, userID: Int) async throws -> DemoToDo.Todo {
        <#code#>
    }
    
    func updateToDoList(isCompleted: Bool, id: Int) async throws -> DemoToDo.Todo {
        <#code#>
    }
    
    func deleteToDoList(id: Int) async throws -> DemoToDo.Todo {
        <#code#>
    }
    
    func getToDoList(for url: URL) async throws -> DemoToDo.ToDoModel {
        do {
            let bundle = Bundle(for: FakeNetworkManager.self)
            guard let path =  bundle.url(forResource:url.absoluteString, withExtension: "json") else {
                throw NetworkError.invalidURL
            }
            let data = try Data(contentsOf: path)
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let lists = try decoder.decode(ToDoModel.self, from: data )
            return lists
        } catch {
            throw NetworkError.dataNotFound
        }
    }
}

