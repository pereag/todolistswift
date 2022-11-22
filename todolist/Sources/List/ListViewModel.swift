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
    var currentTodoIndex: Int? = nil
    private var todos: [String] = []
    
    // MARK: - Initializer
    
    func viewDidLoad() {
        repository = ListRepository(stack: context.stack)
        todos = repository!.getTodos()
        displayTodoList?(todos)
    }
    
    //MARK: Outputs
    
    var displayTodoList: (([String]) -> Void)?
    var displayedAlert: ((AlertContent) -> Void)?
    var displayedTextFieldAlert: ((textFieldAlertContent) -> Void)?
    
    // MARK: Inputs
    
    func didPressAdd(todo: String) {
        let todoClean = todo.trimmingCharacters(in: .whitespaces)
        if todoClean != "" {
            repository?.addTodo(content: todo)
            todos = repository!.getTodos()
            displayTodoList?(todos)
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
    
    func didPressRemoveTodo(index: Int){
        repository?.removeTodo(index: index)
        todos = repository!.getTodos()
        displayTodoList?(todos)
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
        
        if content == "" {
            didPressRemoveTodo(index: index)
        } else {
            repository?.editTodo(index: index, content: content)
            todos = repository!.getTodos()
            displayTodoList?(todos)
        }
    }
}
