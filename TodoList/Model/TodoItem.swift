//
//  TodoItem.swift
//  TodoList
//
//  Created by Park Sang Wook on 5/21/24.
//

import Foundation

struct TodoItem: Identifiable {
    var id = UUID()
    var title: String
    var isCompleted: Bool = false
    
    
}
