//
//  ListViewModelTest.swift
//  todolistTests
//
//  Created by Valc0d3 on 30/09/2022.
//

import XCTest
@testable import todolist

final class ListViewModelTests: XCTestCase {
    private var viewModel: ListViewModel!
    
    func testViewDidLoad() {
        viewModel = ListViewModel()
        viewModel.viewDidLoad()
    }
    
    func testDidPressAddWhenTodoIsNotEmty() {
        viewModel = ListViewModel()
        viewModel.viewDidLoad()
        viewModel.didPressAdd(todo: "yolo")
        let a: String = "yolo"
        
        XCTAssertEqual(a, "yolo")
    }
    
    /* func testDidPressAddWhenTodoIsEmty() {
        
    }
    
    func testDidPressRemoveTodoWhenRepositoryIsNotNil() {
        
    }
    
    func testDidPressRemoveTodoWhenRepositoryIsNil() {
        
    }
    
    func testDidPressEditTodo() {
        
    }
    
    func testChangeTodoValueIfIndexIsNil() {
        
    }
    
    func testChangeTodoValueIfContentIsNotEmpty() {
        
    }
    
    func testChangeTodoValueIfContentIsEmpty() {
        
    }
    
    func testChangeTodoValueIfContentIsEmptyAndRepositoryIsNil() {
        
    }
    
    func testChangeTodoValueIfContentIsEmptyAndRepositoryIsNotNil() {
        
    } */
}

