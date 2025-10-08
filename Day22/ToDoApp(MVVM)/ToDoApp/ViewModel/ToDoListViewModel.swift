//
//  ToDoListViewModel.swift
//  ToDoApp
//
//  Created by mac on 08.10.2025.
//

import Foundation

class ToDoListViewModel {
    // Масив завдань
    private(set) var tasks: [Task] = []     //  private(set) - захищає масив від змін ззовні
    
    // Closure для сповіщення контролера про зміни
    var onTasksUpdated: (() -> Void)?       // cповіщає контролер про зміни, щоб UI оновлювався
    
    // Додаємо завдання
    func addTask(title: String) {
        let task = Task(title: title, isDone: false)
        tasks.append(task)
        onTasksUpdated?()
    }
    
    // Видаляємо завдання
    func deleteTask(at index: Int) {
        // безпечна перевірка перед видаленням або зміною завдання, щоб уникнути помилок
        // tasks.indices — це діапазон індексів масиву tasks
        guard tasks.indices.contains(index) else { return }
        tasks.remove(at: index)
        onTasksUpdated?()
    }
    
    // Перемикаємо статус завдання (done/undone)
    func toggleTask(at index: Int) {
        guard tasks.indices.contains(index) else { return }
        tasks[index].isDone.toggle()   // змінює булеве значення на протилежне (true ↔ false)
        onTasksUpdated?()
    }
    
    // Аліас для сумісності, якщо десь ще використовував toogleTask
    func toogleTask(at index: Int) { toggleTask(at: index) }
    
    // оновлення завдання після редагування
    func updateTask(_ updatedTask: Task) {
        if let index = tasks.firstIndex(where: { $0.id == updatedTask.id }) {
            tasks[index] = updatedTask
            onTasksUpdated?()
        }
    }
    
}
