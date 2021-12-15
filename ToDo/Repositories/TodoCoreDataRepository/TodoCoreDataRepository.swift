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
            
            let exists = self.findById(todo.id)
            
            if (exists != nil) {
                self.update(exists!, todo, todoEntity, viewContext, promise)
            } else {
                self.create(todo, todoEntity, viewContext, promise)
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
    
    func delete(todo: Todo) -> Future<Void, Never> {
        return Future { promise in
            let viewContext = PersistenceController.shared.container.viewContext
            let todoToDelete = self.findById(todo.id)
            
            if (todoToDelete == nil) {
                promise(.success(()))
            } else {
                viewContext.delete(todoToDelete!)
                do {
                    try viewContext.save()
                } catch {
                    fatalError("\(error)")
                }
            }
        }
    }
    
    fileprivate func update(_ todo: ToDoItem, _ newValue: Todo, _ todoEntity: NSEntityDescription, _ viewContext: NSManagedObjectContext, _ promise: (Result<Todo, Never>) -> Void) {
        
        todo.setValue(newValue.doneDate, forKey: "done_date")
        todo.setValue(newValue.isDone, forKey: "is_done")
        todo.setValue(newValue.description, forKey: "descr")
        
        do {
            try viewContext.save()
            promise(.success(newValue))
        } catch {
            fatalError("\(error)")
        }
    }
    
    fileprivate func create(_ todo: Todo, _ todoEntity: NSEntityDescription, _ viewContext: NSManagedObjectContext, _ promise: (Result<Todo, Never>) -> Void) {
        
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
    
    fileprivate func findById(_ id: UUID) -> ToDoItem? {
        let viewContext = PersistenceController.shared.container.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName: self.entityName)
        request.predicate = NSPredicate(format: "id = %@", id.uuidString)
        
        do {
            let result = try viewContext.fetch(request)
            if (result.count != 1) {
                return nil
            }
            
            return result[0] as? ToDoItem
        } catch {
            return nil
        }
    }
    
}
