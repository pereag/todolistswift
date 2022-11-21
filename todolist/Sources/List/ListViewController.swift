//
//  ViewController.swift
//  todolist
//
//  Created by Valc0d3 on 30/09/2022.
//

import UIKit

class ListViewController: UIViewController {
    
    private let listViewModel = ListViewModel()
    private let dataSource = ListViewDataSource()
    private let Todo: [String] = []

    // MARK: Inputs
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var todoTextField: UITextField!
    @IBOutlet private weak var todoTableView: UITableView!
    
    // MARK: LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        listViewModel.viewDidLoad()
        dataSource.config(listViewModel: listViewModel)
        todoTableView.dataSource = dataSource
        todoTableView.delegate = dataSource
    }
    
    private func bindViewModel() {
        listViewModel.displayTodoList = { [weak self] items in
            self?.dataSource.update(items: items)
            self?.todoTableView.reloadData()
        }
        listViewModel.displayedAlert = { [weak self] alertContent in
            DispatchQueue.main.async {
                self?.presentAlert(content: alertContent)
            }
        }
        
        listViewModel.displayedTextFieldAlert = { [weak self] textFieldAlertContent in
            DispatchQueue.main.async {
                self?.presentAlertWithField(content: textFieldAlertContent, listViewModel: self!.listViewModel)
            }
        }
    }
    
    private func bindDataSource() {
        
    }
    
    // MARK: Output
    @IBAction func didPressAddButton(_ sender: Any) {
        listViewModel.didPressAdd(todo: todoTextField.text ?? "")
        todoTextField.text = ""
    }
}

extension UIViewController {
    func presentAlert(content: AlertContent){
        let alertVC = UIAlertController( title: content.title, message: content.message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: content.cancelTitle, style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func presentAlertWithField(content: textFieldAlertContent, listViewModel: ListViewModel) {
        var value: String = "" {
            didSet {
                listViewModel.changeTodoValue(content: value)
            }
        }
        let alertVC = UIAlertController( title: content.title, message: content.message, preferredStyle: .alert)
        alertVC.addTextField {(textField) in
            textField.text = content.textField
        }
        
        alertVC.addAction(UIAlertAction(title: content.cancelTitle, style: .default, handler: { [weak alertVC] (_) in
            let textField = alertVC!.textFields![0]// Force unwrapping because we know it exists.
            value = String(describing: textField.text)
            
        }))
        self.present(alertVC, animated: true, completion: nil)
        print("Text field:", String(describing: alertVC.textFields![0].text))
        
        
    }
}

