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
        WindowGroup {
            ToDoListView(viewModel: ToDoListViewModel(repository: ToDoRepositoryImplementation(networkManager: NetworkManager())))
        }
    }
}
