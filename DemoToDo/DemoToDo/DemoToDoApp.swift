//
//  DemoToDoApp.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import SwiftUI

@main
struct DemoToDoApp: App {
    var body: some Scene {
        
        // MARK: - Creating TodoListView with view model Repository and NetworkManager  .
        WindowGroup {
            ToDoListView(viewModel: ToDoListViewModel(repository: ToDoRepositoryImplementation(networkManager: NetworkManager())))
        }
    }
}
