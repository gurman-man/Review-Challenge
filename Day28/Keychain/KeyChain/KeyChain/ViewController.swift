//
//  ViewController.swift
//  KeyChain
//
//  Created by mac on 17.10.2025.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    // MARK: - Properties
    private var currentPassword: String = "" {
        didSet {
            passwordLabel.text = currentPassword.isEmpty
            ? "No password saved"
            : currentPassword
        }
    }
    
    private let keychainManager = KeychainManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        loadSavedPassword()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        passwordTextField.isSecureTextEntry = true  // щоб замінювало символи на крапки
    }

    @IBAction func savePasswordTapped(_ sender: UIButton) {
        guard let text = passwordTextField.text, !text.isEmpty else { return }
        
        let success = keychainManager.savePassword(text)
        if success {
            currentPassword = text // ось тут ми оновлюємо лише currentPassword
        } else {
            passwordLabel.text = "❌ Failed to save password"
        }
        passwordTextField.text = ""
    }
    
    @IBAction func deletePasswordTapped(_ sender: UIButton) {
        let success = keychainManager.deletePassword()
        if success {
            currentPassword = ""   // автоматично оновиться лейбл
        } else {
            passwordLabel.text = "❌ Failed to delete password"
        }
    }
    
    // MARK: - Load Password
    private func loadSavedPassword() {
        if let savedPassword = keychainManager.getPassword() {
            currentPassword = savedPassword
        } else {
            currentPassword = ""
        }
    }
}

