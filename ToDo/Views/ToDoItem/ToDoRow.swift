//
//  ToDoRow.swift
//  ToDo
//
//  Created by Marcus Adriano on 21/10/21.
//

import SwiftUI

struct ToDoRow: View {
    
    var todo: ToDoItem
    
    @Environment(\.managedObjectContext) private var viewContext
    
    var body: some View {
        
        let isDone = Binding(get: { self.todo.is_done }, set: {
            todo.is_done = $0
            
            do {
                try viewContext.save()
            } catch {
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        })
        
        HStack {
            Text("\(todo.descr ?? "(no description)")")
            
            Spacer()
            
            Toggle(isOn: isDone) {
                Text("")
            }
        }
    }
}
