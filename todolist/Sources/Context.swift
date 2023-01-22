//
//  Context.swift
//  todolist
//
//  Created by Valc0d3 on 14/11/2022.
//

import Foundation

final class Context {
    let stack: CoreDataStack
    
    init() {
        stack = CoreDataStack(modelName: "Todo", type: .prod)
    }
}
