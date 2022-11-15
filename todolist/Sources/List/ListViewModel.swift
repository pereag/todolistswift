//
//  ListViewModel.swift
//  todolist
//
//  Created by Valc0d3 on 30/09/2022.
//

import Foundation

class ListViewModel {
    
    // MARK: - Properties
    var context: Context? = nil
    var repository: ListRepository? = nil
    private var todos: [String] = [] {
        didSet {
            
            if let lastElement = todos.last {
                
                repository!.addTodo(content: lastElement)
            }
        }
    }
    
    // MARK: - Initializer
    
    func viewDidLoad() {
        context = Context.init()
        
        repository = ListRepository(stack: context!.stack)
        
        displayTodoList?(todos)
    }
    
    //MARK: Outputs
    
    var displayTodoList: (([String]) -> Void)?
    var displayedAlert: ((AlertContent) -> Void)?
    
    // MARK: Inputs
    
    func didPressAdd(todo: String) {
        let todoClean = todo.trimmingCharacters(in: .whitespaces)
        if todoClean != "" {
            todos.append(todo)
            print(todos)
        } else {
            let alertContent = AlertContent(
                title: "Alert",
                message: "The todo field is empty.",
                cancelTitle: "Ok"
            )
            self.displayedAlert?(alertContent)
            
            print(todoClean)
        }
    }
    
    // MARK: Endpoint
    
    
}
