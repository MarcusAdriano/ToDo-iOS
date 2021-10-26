//
//  ToDoRow.swift
//  ToDo
//
//  Created by Marcus Adriano on 21/10/21.
//

import SwiftUI

struct ToDoRow: View {
    
    var todo: Todo
    
    var body: some View {
        
        let isDone = Binding<Bool>(get: { self.todo.isDone }, set: { _ in
            // TODO: Implement logic when is done is tapped!
        })
        
        HStack {
            Text(todo.description)
            
            Spacer()
            
            Toggle(isOn: isDone) {
                Text("")
            }
        }
    }
}
