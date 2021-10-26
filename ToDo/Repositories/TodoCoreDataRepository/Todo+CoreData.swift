//
//  Todo+CoreData.swift
//  ToDo
//
//  Created by Marcus Adriano on 25/10/21.
//

import Foundation
import CoreData

extension Todo {
    
    init(for managedObject: NSManagedObject) {
        description = managedObject.value(forKey: "descr") as! String
        isDone = managedObject.value(forKey: "is_done") as? Bool ?? false
        createDate = managedObject.value(forKey: "create_date") as! Date
        doneDate = managedObject.value(forKey: "done_date") as? Date
        id = managedObject.value(forKey: "id") as! UUID
    }
    
    static func from(_ managedObjects: [NSManagedObject]) -> [Todo] {
        return managedObjects.map { managedObject in
            Todo(for: managedObject)
        }
    }
}
