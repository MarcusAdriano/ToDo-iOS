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
    
    private let entityName = "ToDo"
    
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
