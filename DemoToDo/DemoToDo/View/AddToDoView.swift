//
//  AddToDoView.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import SwiftUI

struct AddToDoView: View {
    @Environment(\.dismiss) var dismiss
    @State var todo: String = ""
    @State var userId: String = ""
    @State var isCompleted: Bool = false
    @StateObject var viewModel: ToDoListViewModel
    @State var isEditibale: Bool?
    @State var editiableToDoItem: Todo?
    
    var body: some View {
        NavigationView {
            VStack {
                if let isEditibale = isEditibale, isEditibale {
                    Toggle("Is Completed", isOn: $isCompleted)
                    
                    Button("Update ToDo") {
                        Task {
                            let updateTodoItem = try await viewModel.updateToDoList(isCompleted: isCompleted, id: editiableToDoItem?.id ?? 0)
                            
                            if let item = editiableToDoItem, let itemId = viewModel.todoLists.firstIndex(of: item) {
                                viewModel.todoLists[itemId] = updateTodoItem
                                dismiss()
                                
                            }
                        }
                    }
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .frame(width: 150 , height: 40)
                    .cornerRadius(10)
                } else {
                    HStack {
                        Text("ToDo:")
                        TextField("Enter Todo description", text: $todo)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.subheadline)
                    }
                    HStack {
                        Text("User ID:")
                        TextField("Enter user ID", text: $userId)
                            .keyboardType(.numberPad)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .font(.subheadline)
                    }
                    
                    Toggle("Is Completed", isOn: $isCompleted)
                    
                    Button("Add ToDo") {
                        Task {
                            let todoItem = try await viewModel.addToDoList(todo: todo, isCompleted: isCompleted, userID: Int(userId) ?? 0)
                            viewModel.todoLists.insert(contentsOf: [todoItem], at: 0)
                            dismiss()
                        }
                    }
                    .background(Color(.systemBlue))
                    .foregroundColor(.white)
                    .frame(width: 150 , height: 40)
                    .cornerRadius(10)
                }
                
            } .padding(10)
        } .navigationTitle((isEditibale ?? false) ? "Update Todo" : "Add todo")
        
            .onAppear {
                if isEditibale ?? false {
                    isCompleted = editiableToDoItem?.completed ?? false
                }
            }
    }
}

struct AddToDoView_Previews: PreviewProvider {
    static var previews: some View {
        AddToDoView(viewModel: ToDoListViewModel(repository: ToDoRepositoryImplementation(networkManager: NetworkManager())))
    }
}