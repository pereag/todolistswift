//
//  ItemTableViewCell.swift
//  todolist
//
//  Created by Valc0d3 on 27/10/2022.
//

import UIKit

final class ItemTableViewCell: UITableViewCell {
    var index: IndexPath?
    
    // MARK: - Input
    @IBOutlet weak var todoContentLabel: UILabel!
    @IBOutlet weak var editButtonLabel: NSLayoutConstraint!
    
    // MARK: Outputs
    @IBAction func didPressEditButton(_ sender: Any) {
        
    }
}
