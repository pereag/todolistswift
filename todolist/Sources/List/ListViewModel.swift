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
    
    func didPressRemoveTodo(index: Int){
        if repository != nil {
            repository!.removeTodo(index: index)
            todos = repository!.getTodos()
            displayTodoList?(todos)
        } else {
            getAlertContentForAnOtherError()
        }
    }
    
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
    
    private func getAlertContentForAnOtherError() {
        let alertContent = AlertContent(
            title: "Alert",
            message: "An error has occurred, please try again later.",
            cancelTitle: "Ok"
        )
        self.displayedAlert?(alertContent)
    }
}
