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
        stack.spacing = 35
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
        addButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        addButton.backgroundColor = .white
        addButton.layer.borderColor = UIColor.black.cgColor
        addButton.layer.borderWidth = 4
        addButton.layer.cornerRadius = 20
        addButton.addTarget(self, action: #selector(buttonAddTapped), for: .touchUpInside)
        addButton.tintColor = UIColor.systemPink
        stackView.addSubview(addButton)
        
        
        // --- Button2 ---
        clearButton.setTitle("Clear Tasks", for: .normal)
        clearButton.titleLabel?.font = UIFont.systemFont(ofSize: 22, weight: .medium)
        clearButton.backgroundColor = .white
        clearButton.layer.borderColor = UIColor.black.cgColor
        clearButton.layer.borderWidth = 4
        clearButton.layer.cornerRadius = 20
        clearButton.addTarget(self, action: #selector(buttonClearTapped), for: .touchUpInside)
        clearButton.tintColor = UIColor.systemCyan
        stackView.addSubview(clearButton)
        
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(clearButton)
        
        // Це створить відступи всередині stackView для всіх його arrangedSubviews.
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 20, left: 20, bottom: 50, right: 20)
        
        // Item's constraint
        NSLayoutConstraint.activate([
            //  --- setting addButton
            addButton.widthAnchor.constraint(equalToConstant: 120),
            addButton.heightAnchor.constraint(equalToConstant: 20),
            
            // --- setting clearButton
            clearButton.widthAnchor.constraint(equalToConstant: 120),
            clearButton.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
    
    @objc func buttonAddTapped() {
        tasks.append("New Task")
        label.text = "Tasks count: \(tasks.count)"
        addButton.backgroundColor = randomColor()
    }
    
    @objc func buttonClearTapped() {
        tasks.removeAll()
        label.text = "Tasks count: 0"
        clearButton.backgroundColor = randomColor()
    }
    
    func randomColor() -> UIColor {
        return UIColor(
            red: .random(in: 0...1),
            green: .random(in: 0...1),
            blue: .random(in: 0...1),
            alpha: .random(in: 0...1)
        )
    }

}

