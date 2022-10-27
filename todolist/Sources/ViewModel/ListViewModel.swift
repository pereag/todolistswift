//
//  ListViewModel.swift
//  todolist
//
//  Created by Valc0d3 on 30/09/2022.
//

import Foundation

class ListViewModel {
    
    // MARK: - Properties
    
    private var todos: [String] = [] {
        didSet {
            // Add string in coredata
        }
    }
    
    // MARK: - Initializer
    
    func viewDidLoad() {
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
