//
//  NewItem.swift
//  ToDo
//
//  Created by Marcus Adriano on 20/10/21.
//

import SwiftUI

struct NewItem: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    @State private var description: String = ""
    @Binding var isVisible: Bool
    
    var body: some View {
        Form {
            TextField("Description", text: $description)
        }.toolbar {
            ToolbarItem {
                Button(action: addItem) {
                    Image(systemName: "tray.and.arrow.down.fill")
                }
            }
        }
    }
    
    private func addItem() {
        withAnimation {
            let newItem = ToDoItem(context: viewContext)
            newItem.create_date = Date()
            newItem.descr = description
            newItem.is_done = false
            newItem.id = UUID()
            
            do {
                try viewContext.save()
                isVisible.toggle()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

struct NewItem_Previews: PreviewProvider {
    
    @State private static var isVisible: Bool = true
    
    static var previews: some View {
        NewItem(isVisible: $isVisible)
            .environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
