//
//  ToDoListViewController.swift
//  ToDoApp
//
//  Created by mac on 05.09.2025.
//

import UIKit

extension ToDoListViewController: TaskDetailDelegate {
    func taskDetailVC(_ controller: TaskDetailViewController, didSaveTask task: String) {
        tasks.append(task)
        tableView.reloadData()
    }
}

class ToDoListViewController: UITableViewController {
    var tasks: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "ToDoApp"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addTask))
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoCell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Створюємо екземпляр другого екрану
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "TaskDetailVC") as? TaskDetailViewController {
            
            // Передаємо дані
            detailVC.taskText = "Task \(indexPath.row + 1)"
            // Пушимо його в NavigationController
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }
    
    
    // Реалізація swipe to delete
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    
    @objc func addTask() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let detailVC = storyboard.instantiateViewController(withIdentifier: "TaskDetailVC") as? TaskDetailViewController {
            // ❗️Встановлюємо делегата
            detailVC.delegate = self
            navigationController?.pushViewController(detailVC, animated: true)
        }
    }

}
