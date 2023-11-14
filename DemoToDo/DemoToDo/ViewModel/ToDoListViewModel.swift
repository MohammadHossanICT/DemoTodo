//
//  ToDoListViewModel.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import Foundation
import Combine

enum ViewState {
    case load(todos: [Todo])
    case refresh
    case error
}

protocol ToDoListViewModelAction: ObservableObject {
    func getToDoList(urlStr: String) async
    func addToDoList(todo: String, isCompleted: Bool, userID: Int) async
    func updateToDoList(isCompleted: Bool, id: Int) async
    func deleteToDoList(id: Int) async
}

// MARK: - Todo ViewModel Implementation.
@MainActor
final class ToDoListViewModel {
    @Published var viewState = ViewState.load(todos: [])
    var isError = false
    private(set) var customError: NetworkError?
    private(set) var todoLists: [Todo] = []
    private let repository: ToDoCardsRepository
    
    init(repository: ToDoCardsRepository) {
        self.repository = repository
    }
}
extension ToDoListViewModel: ToDoListViewModelAction {
    
    func deleteToDoList(id: Int) async {
        do {
            let todoItem = try await repository.deleteToDoList(id: id)
            if let index = todoLists.firstIndex(of: todoItem) {
                todoLists.remove(at: index)
            }
            viewState = .load(todos: todoLists)
            
        } catch {
            viewState = .error
            isError = true
            customError = error as? NetworkError
        }
    }
    
    func updateToDoList(isCompleted: Bool, id: Int) async {
        do {
            let todoItem = try await repository.updateToDoList(isCompleted: isCompleted, id: id)
            if let itemId = todoLists.firstIndex(of: todoItem) {
                todoLists[itemId] = todoItem
            }
            viewState = .load(todos: todoLists)
        } catch {
            viewState = .error
            isError = true
            customError = error as? NetworkError
        }
    }
    
    func addToDoList(todo: String, isCompleted: Bool, userID: Int) async {
        do {
            let todoItem = try await repository.addToDoList(todo: todo, isCompleted: isCompleted, userID: userID)
            todoLists.insert(contentsOf: [todoItem], at: 0)
            viewState = .load(todos: todoLists)
        } catch {
            viewState = .error
            isError = true
            customError = error as? NetworkError
        }
    }
    
    func getToDoList(urlStr: String) async {
        viewState = .refresh
        guard let url = URL(string: urlStr) else {
            self.customError = NetworkError.invalidURL
            return
        }
        do {
            let lists = try await repository.getToDoList(for: url)
            todoLists = lists.todos
            viewState = .load(todos: todoLists)
        } catch {
            customError = error as? NetworkError
            isError = true
            viewState = .error
        }
    }
}
