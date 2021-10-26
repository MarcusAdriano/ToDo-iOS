//
//  ContentView.swift
//  ToDo
//
//  Created by Marcus Adriano on 20/10/21.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject var todoViewModel = TodoViewModel(TodoCoreDataRepository())
    
    @State private var showOnlyUndone: Bool = true
    @State private var isNewItemScreenVisible: Bool = false

    var body: some View {
        NavigationView {
            List {
                ForEach(todos()) { item in
                    
                    ToDoRow(todo: item)
                    
                }
            }
            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
                ToolbarItem {
                    NavigationLink(isActive: $isNewItemScreenVisible) {
                        NewItem(isVisible: $isNewItemScreenVisible)
                            .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
                    } label: {
                        Label("Add Item", systemImage: "plus")
                    }
                }
            }
            Text("Select an item")
        }.environmentObject(todoViewModel)
            .onAppear {
                todoViewModel.fetchAll()
            }
    }
    
    private func todos() -> [Todo] {
        todoViewModel.todos.filter( { $0.isDone != self.showOnlyUndone } )
    }
}
