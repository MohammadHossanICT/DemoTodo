//
//  ToDoCellView.swift
//  DemoToDo
//
//  Created by MohammadHossan on 14/11/2023.
//

import SwiftUI

struct ToDoCellView: View {
    
    let toDoList: Todo
    
    var body: some View {
        
        VStack(alignment: .leading,spacing: 5) {
            Text("ID: " + String(toDoList.id))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.headline)
            
            Text("User ID: " + String(toDoList.userID))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("ToDo: " + toDoList.todo)
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Text("Iscompleted: " + String(toDoList.completed))
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(.subheadline)
        }.padding(5)
    }
}


struct ToDoCellView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoCellView(toDoList: ToDoListPreview.previewToDoList)
    }
}
