//
//  todolistTests.swift
//  todolistTests
//
//  Created by Valc0d3 on 27/11/2022.
//

import XCTest
@testable import todolist

import XCTest
@testable import todolist

class ListViewModelTests: XCTestCase {
    
    var sut: ListViewModel!
    var mockRepository: MockListRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockListRepository()
        sut = ListViewModel(repository: mockRepository, todos: [])
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    func testViewDidLoadCallsGetTodos() {
        sut.viewDidLoad()
        XCTAssertTrue(mockRepository.getTodosCalled)
    }
    
    func testViewDidLoadCallsDisplayTodoListWithExpectedTodos() {
        let expectedTodos = ["Test Todo"]
        var passedTodos: [String]?
        mockRepository.stubbedGetTodosResult = expectedTodos
        sut.displayTodoList = { todos in passedTodos = todos }
        sut.viewDidLoad()
        XCTAssertEqual(passedTodos, expectedTodos)
    }
    
    func testViewDidLoadCallsDisplayTodoList() {
        var displayTodoListCalled = false
        sut.displayTodoList = { _ in displayTodoListCalled = true }
        sut.viewDidLoad()
        XCTAssertTrue(displayTodoListCalled)
    }
    
    func testDidPressAddCallsAddTodo() {
        sut.didPressAdd(todo: "Test Todo")
        XCTAssertTrue(mockRepository.addTodoCalled)
    }
    
    func testDidPressAddCallsGetTodos() {
        sut.didPressAdd(todo: "Test Todo")
        XCTAssertTrue(mockRepository.getTodosCalled)
    }
    
    func testDidPressAddCallsDisplayTodoList() {
        var displayTodoListCalled = false
        sut.displayTodoList = { _ in displayTodoListCalled = true }
        sut.didPressAdd(todo: "Test Todo")
        XCTAssertTrue(displayTodoListCalled)
    }
    
    func testDidPressRemoveTodoCallsRemoveTodo() {
        sut.didPressRemoveTodo(index: 0)
        XCTAssertTrue(mockRepository.removeTodoCalled)
    }
    
    func testDidPressRemoveTodoCallsGetTodos() {
        sut.didPressRemoveTodo(index: 0)
        XCTAssertTrue(mockRepository.getTodosCalled)
    }
    
    func testDidPressRemoveTodoCallsDisplayTodoList() {
        var displayTodoListCalled = false
        sut.displayTodoList = { _ in displayTodoListCalled = true }
        sut.didPressRemoveTodo(index: 0)
        XCTAssertTrue(displayTodoListCalled)
    }
    
    func testDidPressAddCallsGetAlertContentForAnOtherErrorWhenTodoIsEmpty() {
        var displayedAlert: AlertContent?
        sut.displayedAlert = { alertContent in displayedAlert = alertContent }
        sut.didPressAdd(todo: "")
        XCTAssertEqual(displayedAlert?.title, "Alert")
        XCTAssertEqual(displayedAlert?.message, "An error has occurred, please try again later.")
        XCTAssertEqual(displayedAlert?.cancelTitle, "Ok")
    }

    /* func testDidPressEditTodoDisplaysTextFieldAlert() {
           let expectedTextFieldAlertContent = textFieldAlertContent(
               title: "Alert",
               message: "Edit your todo content.",
               textField: "",
               cancelTitle: "Ok"
           )
           var capturedTextFieldAlertContent: textFieldAlertContent?
           sut.displayedTextFieldAlert = { textFieldAlertContent in
               capturedTextFieldAlertContent = textFieldAlertContent
           }
           let index = 0
           sut.didPressEditTodo(index: index, todoContent: "")
           XCTAssertEqual(capturedTextFieldAlertContent, expectedTextFieldAlertContent)
       } */
       
       func testChangeTodoValueWithEmptyContentCallsRemoveTodo() {
           let index = 0
           sut.changeTodoValue(content: "")
           XCTAssertTrue(mockRepository.removeTodoCalled)
           XCTAssertEqual(mockRepository.invokedRemoveTodoParameters, index)
       }
       
       func testChangeTodoValueWithNonEmptyContentCallsEditTodo() {
           let index = 0
           let content = "New Todo Content"
           sut.changeTodoValue(content: content)
           XCTAssertTrue(mockRepository.editTodoCalled)
           XCTAssertEqual(mockRepository.invokedEditTodoParameters?.index, index)
           XCTAssertEqual(mockRepository.invokedEditTodoParameters?.content, content)
       }
}

class MockListRepository: ListRepositoryType {
    var addTodoCalled = false
    var removeTodoCalled = false
    var getTodosCalled = false
    var editTodoCalled = false
    var stubbedGetTodosResult: [String] = []
    var invokedEditTodoParameters: (index: Int, content: String)?
    var invokedRemoveTodoParameters: Int?
    
    func addTodo(content: String) {
        addTodoCalled = true
    }

    func removeTodo(index: Int) {
        removeTodoCalled = true
        invokedRemoveTodoParameters = index
    }

    func getTodos() -> [String] {
        getTodosCalled = true
        return stubbedGetTodosResult
    }

    func editTodo(index: Int, content: String) {
        editTodoCalled = true
        invokedEditTodoParameters = (index: index, content: content)
    }
}
