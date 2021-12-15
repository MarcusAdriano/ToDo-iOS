//
//  ToDoRow.swift
//  ToDo
//
//  Created by Marcus Adriano on 21/10/21.
//

import SwiftUI

struct ToDoRow: View {
    
    var onDelete: (_ todo: Todo) -> Void
    var onComplete: (_ todo: Todo) -> Void
    var todo: Todo
    
    var body: some View {
        if #available(iOS 15.0, *) {
            HStack {
                Text(todo.description)
            }
            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                Button {
                    onComplete(todo)
                } label: {
                    Label("Complete", systemImage: "checkmark")
                }
                .tint(.green)
            }
            
            .swipeActions(edge: .leading, allowsFullSwipe: false) {
                Button(role: .destructive) {
                    onDelete(todo)
                } label: {
                    Label("Delete", systemImage: "trash")
                }
                .tint(.red)
            }
        } else {
            Text("iOS < 15")
        }
    }
}

