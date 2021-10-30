//
//  TodoRepository.swift
//  ToDo
//
//  Created by Marcus Adriano on 25/10/21.
//

import Foundation
import Combine

protocol TodoRepository {
    
    func fetchAll() -> Future<[Todo], Never>
    func save(todo: Todo) -> Future<Todo, Never>
    
}
