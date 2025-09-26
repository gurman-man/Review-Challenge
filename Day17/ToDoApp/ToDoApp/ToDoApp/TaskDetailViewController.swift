//
//  TaskDetailViewController.swift
//  ToDoApp
//
//  Created by mac on 26.09.2025.
//

import UIKit

class TaskDetailViewController: UIViewController {

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var taskTextField: UITextField!
    
    var taskText: String?
    var onSave: ((String) -> Void)? // новий параметр
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = taskText == nil ? "New Task" : "Task Detail"
        infoLabel.text = taskText ?? "Enter your task"
        
        view.backgroundColor = UIColor.systemTeal
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        sender.setImage(UIImage(systemName: "checkmark.circle"), for: .normal)
        guard let text = taskTextField.text, !text.isEmpty else { return }
        onSave?(text) // повертаємо текст назад у список
        infoLabel.text = "You enter: \(text)"
    }
    
}
