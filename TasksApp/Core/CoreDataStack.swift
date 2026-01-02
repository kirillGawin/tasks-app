//
//  CoreDataStack.swift
//  TasksApp
//
//  Created by gawin on 02/01/2026.
//

import CoreData

final class CoreDataStack {
    static let shared = CoreDataStack()
    
    let container: NSPersistentContainer
    
    private init() {
        container = NSPersistentContainer(name: "TasksModel")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError("CoreData load error: \(error)")
            }
        }
    }
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func save() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
