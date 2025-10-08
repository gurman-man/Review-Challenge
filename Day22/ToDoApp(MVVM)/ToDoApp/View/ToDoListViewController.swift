//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by mac on 05.09.2025.
//

import UIKit

class ToDoListViewController: UITableViewController {
    let viewModel = ToDoListViewModel()     // додаємо

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ToDoApp"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTask))
        
        // Тепер контролер не змінює дані напряму
        // Коли у ViewModel додається/видаляється/змінюється завдання, closure сповіщає контролер, щоб оновити таблицю
        viewModel.onTasksUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    // MARK: - TableView

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        let task = viewModel.tasks[indexPath.row]
        cell.textLabel?.text = task.title
        cell.accessoryType = task.isDone ? .checkmark : .none
        // Відображення у таблиці через .title
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Створюємо екземпляр другого екрану
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "TaskDetailVC") as? TaskDetailViewController {
            
            // Створюємо ViewModel для TaskDetail і підписуємось на збереження
            let selectedTask = viewModel.tasks[indexPath.row]
            let detailVM = TaskDetailViewModel(task: selectedTask)
            
            detailVM.onTaskSaved = { [weak self] updatedTask in
                self?.viewModel.updateTask(updatedTask)
            }
            
            detailVC.viewModel = detailVM
            // Пушимо його в NavigationController
            navigationController?.pushViewController(detailVC, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    // MARK: - Swipe to delete
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            viewModel.deleteTask(at: indexPath.row)
        }
    }
    
    // MARK: - Add Task
    
    @objc func addTask() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "TaskDetailVC") as? TaskDetailViewController {
            
            let detailVM = TaskDetailViewModel()
            detailVM.onTaskSaved = { [weak self] newTask in
                self?.viewModel.addTask(title: newTask.title)
            }
            
            detailVC.viewModel = detailVM
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}
