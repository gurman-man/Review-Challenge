//
//  ViewController.swift
//  AutoLayout
//
//  Created by mac on 26.09.2025.
//

import UIKit

class ViewController: UIViewController {
    var tasks: [String] = []
    let label = UILabel()
    let addButton = UIButton(type: .system)
    let clearButton = UIButton(type: .system)
    
    let stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 20
        stack.alignment = .center
        stack.distribution = .fillEqually
        stack.backgroundColor = .gray
        stack.clipsToBounds = true
        stack.layer.cornerRadius = 20
        return stack
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stackView.heightAnchor.constraint(equalToConstant: 450),
            stackView.widthAnchor.constraint(equalToConstant: 300)
        ])
        
        // --- Label ---
        label.text = "Tasks count: 0"
        label.textColor = UIColor.green
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        label.textAlignment = .center
        stackView.addSubview(label)
        
        // --- Button ---
        addButton.setTitle("Add Task", for: .normal)
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .light)
        addButton.backgroundColor = .white
        addButton.layer.cornerRadius = 20
        addButton.addTarget(self, action: #selector(buttonAddTapped), for: .touchUpInside)
        addButton.tintColor = UIColor.systemPink
        stackView.addSubview(addButton)
        
        
        // --- Button2 ---
        clearButton.setTitle("Clear Tasks", for: .normal)
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .light)
        clearButton.backgroundColor = .white
        clearButton.layer.cornerRadius = 20
        clearButton.addTarget(self, action: #selector(buttonClearTapped), for: .touchUpInside)
        clearButton.tintColor = UIColor.systemCyan
        stackView.addSubview(clearButton)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(clearButton)
    }
    
    @objc func buttonAddTapped() {
        tasks.append("New Task")
        label.text = "Tasks count: \(tasks.count)"
    }
    
    @objc func buttonClearTapped() {
        tasks.removeAll()
        label.text = "Tasks count: 0"
    }

}

