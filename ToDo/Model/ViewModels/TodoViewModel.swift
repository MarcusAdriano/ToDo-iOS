//
//  TodoViewModel.swift
//  ToDo
//
//  Created by Marcus Adriano on 25/10/21.
//

import Foundation
import Combine

class TodoViewModel: ObservableObject {
    
    @Published private(set) var todos: [Todo] = []
    @Published private(set) var isShowOnlyUndone = true
    @Published var isShowCreateNewItem = false
    
    private var cancellables = Set<AnyCancellable>()
    private var repository: TodoRepository
    
    init(todoRepo repo: TodoRepository) {
        self.repository = repo
    }
    
    // MARK: - Intents
    
    func fetchAll() {
        repository.fetchAll().sink { todos in
            self.todos = todos
        }.store(in: &cancellables)
    }
    
    func toggleDoneFilter() {
        self.isShowOnlyUndone.toggle()
    }
    
    func showCreateNewItem() {
        self.isShowCreateNewItem = true
    }
    
    func closeCreateNewItem() {
        self.isShowCreateNewItem = false
    }
    
    func save(_ description: String) {
        let todo = Todo(description: description, createDate: Date(), id: UUID())
        repository.save(todo: todo).sink { _todos in
            self.closeCreateNewItem()
        }.store(in: &cancellables)
    }
    
}
