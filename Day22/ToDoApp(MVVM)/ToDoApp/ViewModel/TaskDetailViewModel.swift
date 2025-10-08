//
//  TaskDetailViewModel.swift
//  ToDoApp
//
//  Created by mac on 08.10.2025.
//

import Foundation

class TaskDetailViewModel {
    // Поточний Task (якщо редагуємо)
    var task: Task?
    
    var taskTitle: String
    
    // Closure для повідомлення про зміни (опційно)
    var onTaskSaved: ((Task) -> Void)?
    
    init(task: Task? = nil) {
        self.task = task
        self.taskTitle = task?.title ?? ""
    }
    
    // Метод для збереження або створення Task
    func saveTask() {
        if var existingTask = task {
            existingTask.title = taskTitle
            onTaskSaved?(existingTask)
        } else {
            let newTask = Task(title: taskTitle, isDone: false)
            onTaskSaved?(newTask)
        }
    }
}
