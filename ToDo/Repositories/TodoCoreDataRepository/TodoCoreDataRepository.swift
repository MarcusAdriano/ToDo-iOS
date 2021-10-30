//
//  TodoCoreDataRepository.swift
//  ToDo
//
//  Created by Marcus Adriano on 25/10/21.
//

import Foundation
import Combine
import CoreData

class TodoCoreDataRepository: TodoRepository {
    
    private let entityName = "ToDoItem"
    
    func save(todo: Todo) -> Future<Todo, Never> {
        return Future { promise in
            let viewContext = PersistenceController.shared.container.viewContext
            let todoEntity = NSEntityDescription.entity(forEntityName: self.entityName, in: viewContext)!
            
            let todoItem = ToDoItem(entity: todoEntity, insertInto: viewContext)
            todoItem.descr = todo.description
            todoItem.is_done = false
            todoItem.create_date = todo.createDate
            todoItem.id = todo.id
            
            do {
                try viewContext.save()
                promise(.success(todo))
            } catch let error as NSError {
                fatalError("\(error)")
            }
        }
    }
    
    func fetchAll() -> Future<[Todo], Never> {
        return Future { promise in
            let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
            let viewContext = PersistenceController.shared.container.viewContext
            
            do {
                
                let managedObjects = try viewContext.fetch(request)
                promise(.success(Todo.from(managedObjects)))
                
            } catch let error as NSError {
                debugPrint(error)
            }
        }
    }
    
}
