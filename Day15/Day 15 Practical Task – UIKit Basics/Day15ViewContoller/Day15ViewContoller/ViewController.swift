//
//  ViewController.swift
//  Day15ViewContoller
//
//  Created by mac on 24.09.2025.
//

import UIKit

class ViewController: UIViewController {

    let containerView = UIView()
    let label = UILabel()
    let textField = UITextField()
    let button = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        setupViews()
    }

    func setupViews() {
        // вимикаємо autoresizing для ВСІХ елементів
                [containerView, label, textField, button].forEach {
                    $0.translatesAutoresizingMaskIntoConstraints = false
                }
        
        // --- Container View ---
        containerView.backgroundColor = .lightGray
        containerView.layer.cornerRadius = 10
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        // --- Label ---
        label.text = "Hello, UIKit!"
        label.textColor = UIColor.systemIndigo
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        containerView.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
        
        // --- TextField ---
        textField.placeholder = "Enter some text"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        containerView.addSubview(textField)
        
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        // --- UIButton ---
        button.setTitle("Update Label", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.tintColor = UIColor.green
        button.clipsToBounds = true
        button.backgroundColor = UIColor.systemPink
        containerView.addSubview(button)
        
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor),
            button.widthAnchor.constraint(equalToConstant: 160),
            button.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func buttonTapped() {
        guard let text = textField.text, !text.isEmpty else { return }
        label.text = text
        textField.text = ""
    }
}

