//
//  ToDoListView.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import SwiftUI

struct ToDoListView: View {
    
// MARK: - Using State Object to make sure view model object will not destroed or recreate.
    @StateObject var viewModel: ToDoListViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.customError != nil && !viewModel.refreshing {
                    alertView()
                } else {
                    if viewModel.refreshing {
                        progressView()
                    }
                    if viewModel.todoLists.count > 0 && !viewModel.refreshing {
                        
                        List {
                            ForEach(viewModel.todoLists, id: \.self) { todoList in
                                NavigationLink(destination: AddToDoView(viewModel: viewModel, isEditable: true, editableToDoItem: todoList)) {
                                    // MARK: - Configure the Todo Cell.
                                    ToDoCellView(toDoList: todoList)  
                                }
                            }.onDelete { index in
                                let list  = viewModel.todoLists
                                Task {
                                    
                                    let removeItem = try await viewModel.deleteToDoList(id: list[index.first ?? 0].id)
                                    if let index = viewModel.todoLists.firstIndex(of: removeItem) {
                                        viewModel.todoLists.remove(at: index)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle(Text("ToDo List"))
            .navigationBarItems(
                trailing:
                    NavigationLink(destination: AddToDoView( viewModel: viewModel)) {
                        Image(systemName: "plus")
                    })
        }.task {
            await getDataFromAPI()
        }
        .refreshable {
            await getDataFromAPI()
        }
    }
    // MARK: - Making API call call URL .
    func getDataFromAPI() async {
        await viewModel.getToDoList(urlStr: Endpoint.todoUrl)
    }
    
    // MARK: - Using ViewBuilder to create the child view.
    @ViewBuilder
    func progressView() -> some View {
        VStack{
            RoundedRectangle(cornerRadius: 15)
                .fill(.white)
                .frame(height: 180)
                .overlay {
                    VStack{
                        ProgressView().padding(50)
                        Text("Please_Wait_Message").font(.headline)
                    }
                }
        }
    }
    
    @ViewBuilder
    func alertView() -> some View {
        Text("").alert(isPresented: $viewModel.isErrorOccured) {
            Alert(title: Text("General_Error"), message: Text(viewModel.customError?.localizedDescription ?? ""),dismissButton: .default(Text("Okay")))
        }
    }
}
// MARK: - Live Previews .
struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(viewModel: ToDoListViewModel(repository: ToDoRepositoryImplementation(networkManager: NetworkManager())))
    }
}
