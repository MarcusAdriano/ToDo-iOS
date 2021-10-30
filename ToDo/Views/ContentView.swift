//
//  ContentView.swift
//  ToDo
//
//  Created by Marcus Adriano on 20/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
   
    @StateObject var todoViewModel = TodoViewModel(todoRepo: TodoCoreDataRepository())

    var body: some View {
        NavigationView {
            List {
                ForEach(todos()) { item in
                    
                    ToDoRow(todo: item)
                    
                }
            }
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    HStack {
                        Button {
                            todoViewModel.showCreateNewItem()
                        } label: {
                            HStack {
                                Image(systemName: "plus.app.fill")
                                Text("New item")
                            }
                        }
                    }
                }
            }
        }.onAppear {
            todoViewModel.fetchAll()
        }.sheet(isPresented: $todoViewModel.isShowCreateNewItem) {
            NewItem()
        }.environmentObject(todoViewModel)
        .navigationTitle("Todo")
    }
    
    private func todos() -> [Todo] {
        todoViewModel.todos.filter( { $0.isDone != todoViewModel.isShowOnlyUndone } )
    }
}
