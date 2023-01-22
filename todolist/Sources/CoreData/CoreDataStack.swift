//
//  CoreDataStack.swift
//  todolist
//
//  Created by Valc0d3 on 14/11/2022.
//

import UIKit
import CoreData

enum CoreDataStackType {
    case prod
    case test
}

final class CoreDataStack {
    
    private let container: NSPersistentContainer
    
    var context: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(modelName: String, type: CoreDataStackType) {
        container = NSPersistentContainer(name: modelName)
        if type == .test {
            let description = NSPersistentStoreDescription()
            description.type = NSSQLiteStoreType
            container.persistentStoreDescriptions = [description]
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    // MARK: - Core Data Saving support
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
