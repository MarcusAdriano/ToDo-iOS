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

    fileprivate func CreateButton() -> Button<HStack<TupleView<(Image, Text)>>> {
        return Button {
            todoViewModel.showCreateNewItem()
        } label: {
            HStack {
                Image(systemName: "plus.app.fill")
                Text("New item")
            }
        }
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(todos()) { item in
                    
                    ToDoRow(todo: item)
                    
                }
                .onDelete { indexSet in
                    print(indexSet)
                }
            }
            .navigationTitle("Todo")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    EditButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    CreateButton()
                }
            }
        }.onAppear {
            todoViewModel.fetchAll()
        }.sheet(isPresented: $todoViewModel.isShowCreateNewItem) {
            NewItem()
        }.environmentObject(todoViewModel)
    }
    
    private func todos() -> [Todo] {
        todoViewModel.todos.filter( { $0.isDone != todoViewModel.isShowOnlyUndone } )
    }
}
