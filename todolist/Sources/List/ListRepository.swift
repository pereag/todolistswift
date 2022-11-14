//
//  ListViewRepository.swift
//  todolist
//
//  Created by Valc0d3 on 14/11/2022.
//

import Foundation
import CoreData

final class ListRepository : ListRepositoryType {
    private let stack: CoreDataStack
        
    init(stack: CoreDataStack) {
        self.stack = stack
    }
    
    func addTodo(content: String) {
        let todoObject = TodoEntity(context: stack.context)
        todoObject.content = content
        stack.saveContext()
    }
    
    func removeTodo(index: Int) {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()
        do {
            let object = try stack.context.fetch(request)
            if !object.isEmpty {
                stack.context.delete(object[index])
                stack.saveContext()
            }
        } catch {
            print(error)
        }
    }
}

protocol ListRepositoryType {
    func addTodo(content: String)
    
    func removeTodo(index: Int)
}

