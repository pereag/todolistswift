//
//  ListViewModel.swift
//  todolist
//
//  Created by Valc0d3 on 30/09/2022.
//

import Foundation

class ListViewModel {
    
    // MARK: - Properties
    var context: Context = Context.init()
    var repository: ListRepository? = nil
    private var todos: [String] = []
    
    // MARK: - Initializer
    
    func viewDidLoad() {
        repository = ListRepository(stack: context.stack)
        todos = repository!.getTodos()
        displayTodoList?(todos)
        
        print(todos)
        
    }
    
    //MARK: Outputs
    
    var displayTodoList: (([String]) -> Void)?
    var displayedAlert: ((AlertContent) -> Void)?
    
    // MARK: Inputs
    
    func didPressAdd(todo: String) {
        let todoClean = todo.trimmingCharacters(in: .whitespaces)
        if todoClean != "" {
            repository?.addTodo(content: todo)
        } else {
            let alertContent = AlertContent(
                title: "Alert",
                message: "The todo field is empty.",
                cancelTitle: "Ok"
            )
            self.displayedAlert?(alertContent)
            //print(todoClean)
        }
    }
    
    // MARK: Endpoint
    
    
}
