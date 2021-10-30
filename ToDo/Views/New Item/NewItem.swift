//
//  NewItem.swift
//  ToDo
//
//  Created by Marcus Adriano on 20/10/21.
//

import SwiftUI
import Combine

struct NewItem: View {
    
    @EnvironmentObject var todoViewModel: TodoViewModel
    @State private var description: String = ""
    
    var body: some View {
        Form {
            TextField("Description", text: $description)
            Button(action: addItem) {
                Text("Save")
                    .frame(maxWidth: .infinity)
            }
        }
    }
    
    private func addItem() {
        todoViewModel.save(description)
        todoViewModel.fetchAll()
    }
}
