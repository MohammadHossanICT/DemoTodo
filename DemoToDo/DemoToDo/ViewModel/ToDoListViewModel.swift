//
//  ToDoListViewModel.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation
import Combine

protocol ToDoListViewModelAction: ObservableObject {
    func getToDoList(urlStr: String) async
    func addToDoList(todo: String, isCompleted: Bool, userID: Int) async throws -> Todo
    func updateToDoList(isCompleted: Bool, id: Int) async throws -> Todo
    func deleteToDoList(id: Int) async throws -> Todo
}

@MainActor
final class ToDoListViewModel {
    @Published var todoLists: [Todo] = []
    @Published private(set) var customError: NetworkError?
    @Published private(set) var refreshing = true
    @Published var isErrorOccured = false

    private let repository: ToDoCardsRepository
    init(repository: ToDoCardsRepository) {
        self.repository = repository
    }
}
extension ToDoListViewModel: ToDoListViewModelAction {
    func deleteToDoList(id: Int) async throws -> Todo {
        do {
            let todoItem = try await repository.deleteToDoList(id: id)
            isErrorOccured = false
           return todoItem

        } catch {
            isErrorOccured = true
            customError = error as? NetworkError
            throw error
        }
    }

    func updateToDoList(isCompleted: Bool, id: Int) async throws -> Todo {
        do {
            let todoItem = try await repository.updateToDoList(isCompleted: isCompleted, id: id)
            isErrorOccured = false
           return todoItem

        } catch {
            isErrorOccured = true
            customError = error as? NetworkError
            throw error
        }
    }
    
    func addToDoList(todo: String, isCompleted: Bool, userID: Int) async throws -> Todo {
        do {
            let todoItem = try await repository.addToDoList(todo: todo, isCompleted: isCompleted, userID: userID)
            isErrorOccured = false
           return todoItem

        } catch {
            isErrorOccured = true
            customError = error as? NetworkError
            throw error
        }
    }
    
    func getToDoList(urlStr: String) async {
        refreshing = true
        guard let url = URL(string: urlStr) else {
        self.customError = NetworkError.invalidURL
        refreshing = false
        isErrorOccured = false
        return
        }
        do {
            let lists = try await repository.getToDoList(for: url)
            let arr = lists.todos
            refreshing = false
            isErrorOccured = false
            todoLists = arr

        } catch {
            refreshing = false
            isErrorOccured = true
            customError = error as? NetworkError
        }
    }
}


