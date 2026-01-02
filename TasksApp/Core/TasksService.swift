//
//  TasksService.swift
//  TasksApp
//
//  Created by gawin on 02/01/2026.
//

import CoreData

final class TasksService {
    
    private let context = CoreDataStack.shared.context
    
    func createTask(title: String) {
        let task = Task(context: context)
        task.title = title
        task.isCompleted = false
        task.createdAt = Date()
        CoreDataStack.shared.save()
    }
    
    func fetchAll() -> [Task] {
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        request.sortDescriptors = [
            NSSortDescriptor(key: "createdAt", ascending: true)
        ]
        return (try? context.fetch(request)) ?? []
        }
    
    func delete(_ task: Task) {
        context.delete(task)
        CoreDataStack.shared.save()
    }
}

