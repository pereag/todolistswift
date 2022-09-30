//
//  ViewController.swift
//  todolist
//
//  Created by Valc0d3 on 30/09/2022.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Inputs
    
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var addButton: UIButton!
    @IBOutlet private weak var todoTextField: UITextField!
    @IBOutlet var todoTableView: UITableView!
    
    // MARK: Output
    
    @IBAction func didPressAddButton(_ sender: Any) {
    }
    
    
    // MARK: Private
    
    // MARK: LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

