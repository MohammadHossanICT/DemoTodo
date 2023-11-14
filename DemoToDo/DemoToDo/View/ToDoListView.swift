//
//  ToDoListView.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import SwiftUI

struct ToDoListView: View {
    
    // MARK: - Using State Object to make sure view model object will not destroyed or recreate.
    @StateObject var viewModel: ToDoListViewModel
    var body: some View {
        NavigationStack {
            VStack {
                switch viewModel.viewState {
                case .load(todos: let todos):
                    List {
                        ForEach(todos, id: \.self) { todoList in
                            NavigationLink(destination: AddToDoView(viewModel: viewModel, isEditable: true, editableToDoItem: todoList)) {
                                // MARK: - Configure the Todo Cell.
                                ToDoCellView(toDoList: todoList)
                            }
                        }.onDelete { index in
                            let list = viewModel.todoLists
                            Task {
                                await viewModel.deleteToDoList(id: list[index.first ?? 0].id)
                            }
                        }
                    }
                case .refresh:
                    progressView()
                case .error:
                    alertView()
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
                        Text("Please Wait Message").font(.headline)
                    }
                }
        }
    }
    
    @ViewBuilder
    func alertView() -> some View {
        Text("").alert(isPresented: $viewModel.isError) {
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
