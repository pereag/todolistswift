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
                print(object)
                stack.context.delete(object[index])
                stack.saveContext()
            }
        } catch {
            //print(error)
        }
    }
    
    func getTodos() -> [String] {
        let request: NSFetchRequest<TodoEntity> = TodoEntity.fetchRequest()

        guard let result = try? stack.context.fetch(request) else { return [] }
        
        if result.count <= 0 {
            return []
        } else {
            var todos: [String] = []
            for todo in result {
                if (todo.content != nil) {
                    todos.append(todo.content!)
                }
            }
            return todos
        }
    }
}

protocol ListRepositoryType {
    func addTodo(content: String)
    
    func removeTodo(index: Int)
}

