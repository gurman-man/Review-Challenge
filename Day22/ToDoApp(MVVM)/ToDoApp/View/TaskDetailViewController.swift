//
//  TaskDetailViewController.swift
//  ToDoApp
//
//  Created by mac on 26.09.2025.
//

import UIKit

class TaskDetailViewController: UIViewController {
    var viewModel: TaskDetailViewModel!

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var taskTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        view.backgroundColor = UIColor.systemTeal
        
        // Якщо є існуючий task — редагуємо
        if let task = viewModel.task {
            infoLabel.text = "Edit Task"
            taskTextField.text = task.title
        } else {
            // Інакше створюємо новий
            infoLabel.text = "New Task"
            taskTextField.placeholder = "Enter new task"
            taskTextField.text = "" // очищаємо на випадок, якщо щось лишилось
        }
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        view.endEditing(true)   // ховаємо клавіатуру
        viewModel.taskTitle = taskTextField.text ?? ""
        viewModel.saveTask()
        navigationController?.popViewController(animated: true)
    }
}
