

// 데이터 모델

import Foundation

struct TodoList: Identifiable {
    var id: UUID
    var title: String
    var items: [TodoItem]
    var createdDate: Date
    var modifiedDate: Date
    var priority: Priority
    var dueDate: Date?
    
    enum Priority: String, CaseIterable {
        case high = "High"
        case medium = "Medium"
        case low = "Low"
    }
    
    init(title: String, items: [TodoItem], createdDate: Date, modifiedDate: Date, priority: Priority, dueDate: Date? = nil) {
        self.id = UUID()
        self.title = title
        self.items = items
        self.createdDate = createdDate
        self.modifiedDate = modifiedDate
        self.priority = priority
        self.dueDate = dueDate
    }
    
    mutating func addItem(_ item: TodoItem) {
        self.items.append(item)
    }
    
    mutating func removeItem(_ itemID: TodoItem.ID) {
        self.items.removeAll { item in
            item.id == itemID
        }
    }
    
    mutating func toggleCompletion(for itemID: TodoItem.ID) {
        if let index = self.items.firstIndex(where: { $0.id == itemID }) {
            self.items[index].isCompleted.toggle()
        }
    }
}

extension TodoList {
    static var sampleData: TodoList {
        let items: [TodoItem] = [
            TodoItem(title: "Buy groceries"),
            TodoItem(title: "Walk the dog"),
            TodoItem(title: "Finish homework")
        ]
        return .init(title: "Daily Tasks", items: items, createdDate: .now, modifiedDate: .now, priority: .medium)
    }
}


