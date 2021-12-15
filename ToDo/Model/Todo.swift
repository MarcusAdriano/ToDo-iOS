//
//  Todo.swift
//  ToDo
//
//  Created by Marcus Adriano on 25/10/21.
//

import Foundation

struct Todo: Codable, Identifiable {
    
    var description: String
    var isDone: Bool = false
    var createDate: Date
    var doneDate: Date?
    var id: UUID
    
    func markAsDone() -> Todo {
        return Todo(description: description, isDone: true, createDate: createDate, doneDate: Date(), id: id)
    }
}
