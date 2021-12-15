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
                ForEach(getTodos()) { item in
                    
                    ToDoRow(onDelete: { todo in
                        todoViewModel.delete(todo)
                    }, onComplete: { todo in
                        todoViewModel.markAsDone(todo)
                    }, todo: item)
                }                
            }
            .listStyle(PlainListStyle())
            .navigationTitle("My TODOs")
            .toolbar {
                ToolbarItem(placement: .bottomBar) {
                    CreateButton()
                }
                ToolbarItem(placement: .bottomBar) {
                    Spacer()
                }
            }
        }.onAppear {
            todoViewModel.fetchAll()
        }.sheet(isPresented: $todoViewModel.isShowCreateNewItem) {
            NewItem()
        }.environmentObject(todoViewModel)
    }
    
    private func getTodos() -> [Todo] {
        todoViewModel.todos.filter( {
                $0.isDone != todoViewModel.isShowOnlyUndone
            }
        )
    }
}
