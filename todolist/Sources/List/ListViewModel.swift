//
//  ListViewModel.swift
//  todolist
//
//  Created by Valc0d3 on 30/09/2022.
//

import Foundation

class ListViewModel {
    
    // MARK: - Properties
    private var context: Context = Context.init()
    private var repository: ListRepository? = nil
    private var currentTodoIndex: Int? = nil
    private var todos: [String] = []
    
    // MARK: - Initializer
    
    
    // Init repository and use function displayTodoList.
    func viewDidLoad() {
        repository = ListRepository(stack: context.stack)
        if repository != nil {
            todos = repository!.getTodos()
            displayTodoList?(todos)
        } else {
            getAlertContentForAnOtherError()
        }
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
            if repository != nil {
                repository!.addTodo(content: todo)
                todos = repository!.getTodos()
                displayTodoList?(todos)
            } else {
                getAlertContentForAnOtherError()
            }
        } else {
            getAlertContentForAnOtherError()
        }
    }
    
    // Remove todo selected by index.
    func didPressRemoveTodo(index: Int){
        if repository != nil {
            repository!.removeTodo(index: index)
            todos = repository!.getTodos()
            displayTodoList?(todos)
        } else {
            getAlertContentForAnOtherError()
        }
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
            if repository != nil {
                repository?.editTodo(index: index, content: content)
                todos = repository!.getTodos()
                displayTodoList?(todos)
            } else {
                getAlertContentForAnOtherError()
            }
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
