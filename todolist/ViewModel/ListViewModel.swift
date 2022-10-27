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
    
    // MARK: Inputs
    
    func didPressAdd(todo: String) {
        todos.append(todo)
        print(todos)
    }
    
    // MARK: Endpoint
    
    
    
    
}
