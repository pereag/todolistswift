//
//  ViewController.swift
//  todolist
//
//  Created by Valc0d3 on 30/09/2022.
//

import UIKit

class ListViewController: UIViewController {
    
    private let listViewModel = ListViewModel()

    // MARK: Inputs
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var todoTextField: UITextField!
    @IBOutlet private weak var todoTableView: UITableView!
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        listViewModel.viewDidLoad()
    }
    
    // MARK: Output
    @IBAction func didPressAddButton(_ sender: Any) {
        listViewModel.didPressAdd(todo: todoTextField.text ?? "")
        todoTextField.text = ""
    }
}

