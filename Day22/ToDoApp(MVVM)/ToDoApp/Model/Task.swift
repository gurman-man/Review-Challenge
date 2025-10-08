//
//  Task.swift
//  ToDoApp
//
//  Created by mac on 08.10.2025.
//

import Foundation

struct Task: Identifiable, Equatable {
    var title: String
    var isDone: Bool
    let id: UUID
    
    init(id: UUID = UUID(), title: String, isDone: Bool) {
        self.id = id
        self.title = title
        self.isDone = isDone
    }
}
