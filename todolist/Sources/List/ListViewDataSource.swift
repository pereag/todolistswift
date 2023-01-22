//
//  ListViewDataSource.swift
//  todolist
//
//  Created by Valc0d3 on 16/11/2022.
//

import UIKit

final class ListViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {
    
    private var listViewModel : ListViewModel?
    
    private var items: [String] = []
    
    
    // Add ListViewModel in list viewModel var.
    func config(listViewModel: ListViewModel) {
        self.listViewModel = listViewModel
    }
    
    // Update self.items
    func update(items: [String]) {
        self.items = items
    }
    
    var didSelectItemAt: ((Int) -> Void)?
    
    // the three all functions is used for init tableView and TableViewCell.
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard items.indices.contains(indexPath.row) else { return .init() }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ItemTableViewCell", for: indexPath) as! ItemTableViewCell
        
        cell.configure(todo: items[indexPath.row], indexRow: indexPath.row, listViewModel: listViewModel!)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard items.indices.contains(indexPath.row) else { return }
        didSelectItemAt?(indexPath.row)
    }
}
