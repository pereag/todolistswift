//
//  ItemTableViewCell.swift
//  todolist
//
//  Created by Valc0d3 on 27/10/2022.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    var index: Int?
    var listViewModel: ListViewModel?
    
    // MARK: - Input
    @IBOutlet weak var todoContentLabel: UILabel!
    
    // MARK: Outputs
    @IBAction func didPressEditButton(_ sender: Any) {
        print(index!)
    }
    
    @IBAction func didPressRemoveButton(_ sender: Any) {
        listViewModel?.didPressRemoveTodo(index: index!)
    }
    
    func configure(todo: String, indexRow: Int, listViewModel: ListViewModel) {
        todoContentLabel.text = todo
        self.index = indexRow
        self.listViewModel = listViewModel
    }
    
    
}
