//
//  ToDoRepository.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation

protocol ToDoCardsRepository {
    func getToDoList(for url: URL) async throws -> ToDoModel
    func addToDoList(todo: String, isCompleted: Bool, userID: Int) async throws -> Todo
    func updateToDoList(isCompleted: Bool, id: Int) async throws -> Todo
    func deleteToDoList(id: Int) async throws -> Todo
}

struct ToDoRepositoryImplementation {
    private let networkManager: Fetchable

    init(networkManager: Fetchable) {
        self.networkManager = networkManager
    }
}

// MARK: - Todo Repository Implementation.

extension ToDoRepositoryImplementation: ToDoCardsRepository, JsonParser {
    // MARK: - Todo Delete request with json parseing.

    func deleteToDoList(id: Int) async throws -> Todo {
        do {
            let listsData = try await networkManager.delete(id: id)
            return try parse(data: listsData, type: Todo.self)
        } catch {
            throw error
        }
    }
    // MARK: - Todo Update request form Network Layer.
    func updateToDoList(isCompleted: Bool, id: Int) async throws -> Todo {
        do {
            let listsData = try await networkManager.put(isCompleted: isCompleted, id: id)
            return try parse(data: listsData, type: Todo.self)
        } catch {
            throw error
        }
    }
    // MARK: - Todo Add request form Network Layer.
    func addToDoList(todo: String, isCompleted: Bool, userID: Int) async throws -> Todo {
        do {
            let listsData = try await networkManager.post(todo: todo, isCompleted: isCompleted, userID: userID)
            return try parse(data: listsData, type: Todo.self)
        } catch {
            throw error
        }
    }
    
    // MARK: - Todo Get Todo List request form Network Layer.
    func getToDoList(for url: URL) async throws -> ToDoModel {
        do {
            let listsData = try await networkManager.get(url: url)
            return try parse(data: listsData, type: ToDoModel.self)
        } catch {
            throw error
        }
    }
}

