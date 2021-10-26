//
//  TodoViewModel.swift
//  ToDo
//
//  Created by Marcus Adriano on 25/10/21.
//

import Foundation
import Combine

class TodoViewModel: ObservableObject {
    
    private var repository: TodoRepository
    
    private var cancellables = Set<AnyCancellable>()
    
    init(_ repository: TodoRepository) {
        self.repository = repository
    }
    
    @Published var todos: [Todo] = []
    
    func fetchAll() {
        repository.fetchAll().sink { todos in
            self.todos = todos
        }.store(in: &cancellables)
    }
    
}
