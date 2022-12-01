//
//  ListViewModel.swift
//  todolist
//
//  Created by Valc0d3 on 30/09/2022.
//

import Foundation

class ListViewModel {
    
    // MARK: - Properties

    private var repository: ListRepositoryType
    private var currentTodoIndex: Int?
    private var todos: [String]

    // MARK: - Init

    init(
        repository: ListRepositoryType,
        todos: [String]
    ) {
        self.repository = repository
        self.todos = todos
    }
    
    // MARK: - Initializer
    
    // Init repository and use function displayTodoList.
    func viewDidLoad() {
        todos = repository.getTodos()
        displayTodoList?(todos)
    }
    
    //MARK: Outputs
    
    var displayTodoList: (([String]) -> Void)?
    var displayedAlert: ((AlertContent) -> Void)?
    var displayedTextFieldAlert: ((textFieldAlertContent) -> Void)?
    
    // MARK: Inputs
    
    // Add todo in core data if data format is correct.
    func didPressAdd(todo: String) {
        let todoClean = todo.trimmingCharacters(in: .whitespaces)
        if todoClean != "" {
            repository.addTodo(content: todo)
            todos = repository.getTodos()
            displayTodoList?(todos)
        } else {
            getAlertContentForAnOtherError()
        }
    }
    
    // Remove todo selected by index.
    func didPressRemoveTodo(index: Int){
        repository.removeTodo(index: index)
        todos = repository.getTodos()
        displayTodoList?(todos)
    }
    
    // send an alert content with a field for enter the new value.
    func didPressEditTodo(index: Int, todoContent: String) {
        let textFieldAlertContent = textFieldAlertContent(
            title: "Alert",
            message: "Edit your todo content.",
            textField: todoContent,
            cancelTitle: "Ok"
        )
        
        currentTodoIndex = index
        self.displayedTextFieldAlert?(textFieldAlertContent)
    }
    
    // Change old todo value with the new value. If the new value is empty, the todo is removed.
    func changeTodoValue(content: String) {
        guard let index = currentTodoIndex else{ return }
        
        if content.trimmingCharacters(in: .whitespaces) == "" {
            didPressRemoveTodo(index: index)
        } else {
            repository.editTodo(index: index, content: content)
            todos = repository.getTodos()
            displayTodoList?(todos)
        }
    }
    
    // Send alert content
    private func getAlertContentForAnOtherError() {
        let alertContent = AlertContent(
            title: "Alert",
            message: "An error has occurred, please try again later.",
            cancelTitle: "Ok"
        )
        self.displayedAlert?(alertContent)
    }
}
