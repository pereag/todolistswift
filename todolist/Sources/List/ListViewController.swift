//
//  ViewController.swift
//  todolist
//
//  Created by Valc0d3 on 30/09/2022.
//

import UIKit

final class ListViewController: UIViewController, UITextViewDelegate {
    
    private let listViewModel = ListViewModel(
        repository: ListRepository(
            stack: Context.init().stack
        ),
        todos: []
    )
    private let dataSource = ListViewDataSource()
    private let todos: [String] = []

    // MARK: Inputs
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var todoTextField: UITextField!
    @IBOutlet private weak var todoTableView: UITableView!
    
    // MARK: LifeCycle
    
    // Applicate all functions for displayed correctly data from viewModel here.
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
        hideKeyboardWhenTappedAround()
        self.addButtonDoneOnUITextView()
        self.listViewModel.viewDidLoad()
        dataSource.config(listViewModel: listViewModel)
        todoTableView.dataSource = dataSource
        todoTableView.delegate = dataSource
    }
    
    // Add button done On UITextView
    private func addButtonDoneOnUITextView() {
        let toolbar: UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        let flexSpace = UIBarButtonItem(barButtonSystemItem:    .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(dismissMyKeyboard))
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        self.todoTextField.inputAccessoryView = toolbar
    }
        
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
    
    // Wait viewModel closure and applicate the content of this function if data is geted. This function is used for get todos and the Alerts contents.
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
                if self != nil {
                    self?.presentAlertWithField(content: textFieldAlertContent, listViewModel: self!.listViewModel)
                }
            }
        }
    }
    
    // MARK: Output
    
    // On did press Add button, remove text from todoTextField and ask at the viewModel to add todo in coreData.
    @IBAction func didPressAddButton(_ sender: Any) {
        listViewModel.didPressAdd(todo: todoTextField.text ?? "")
        todoTextField.text = ""
    }
}

extension UIViewController {
    
    // Present Alert with the content geted.
    func presentAlert(content: AlertContent){
        let alertVC = UIAlertController( title: content.title, message: content.message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: content.cancelTitle, style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    // Present Alert with field with the content geted.
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
            let textField = alertVC!.textFields![0]
            if textField.text != nil {
                value = String(describing: textField.text!)
            }
        }))
        self.present(alertVC, animated: true, completion: nil)
    }
}

extension UIViewController {
    // hide keyboard when tapped around
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

