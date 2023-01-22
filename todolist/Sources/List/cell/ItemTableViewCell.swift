//
//  ItemTableViewCell.swift
//  todolist
//
//  Created by Valc0d3 on 27/10/2022.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    private var index: Int?
    private weak var listViewModel: ListViewModel?
    
    // MARK: - Input
    @IBOutlet private weak var todoContentLabel: UILabel!
    
    @IBOutlet var removeButton: UIButton!
    
    // MARK: Outputs

    // On did Press remove button, ask at viewModel to remove the todo selected by index.
    @IBAction private func didPressRemoveButton(_ sender: Any) {
        guard let index = index else { return }
        listViewModel?.didPressRemoveTodo(index: index)
    }
    
    // On did Press edit button, ask at viewModel to display alert view field for edit current todo.
    @IBAction private func didPressEditButton(_ sender: Any) {
        guard let index = index else { return }
        guard let todoContent = todoContentLabel.text else { return }
        listViewModel?.didPressEditTodo(index: index, todoContent: todoContent)
    }
    
    // Configure this table view cell
    func configure(todo: String, indexRow: Int, listViewModel: ListViewModel) {
        todoContentLabel.text = todo
        self.index = indexRow
        self.listViewModel = listViewModel
        removeButton.tintColor = .red
        
    }
}
