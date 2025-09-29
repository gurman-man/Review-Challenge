//
//  registerSegmentViewController.swift
//  LoginRegisterApp
//
//  Created by mac on 28.09.2025.
//

import UIKit

class registerSegmentViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmpassTextField: UITextField!
    
    weak var delegate: AuthDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
    }
    
    func setupUI() {
        // Changing Placeholders Color
        emailTextField.attributedPlaceholder = NSAttributedString(
            string: " Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor(hue:  0.58, saturation: 0.58, brightness: 0.85, alpha: 1.0)])
        
        passwordTextField.attributedPlaceholder = NSAttributedString(string: " Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hue: 0.58, saturation: 0.58, brightness: 0.85, alpha: 1.0)])
        
        confirmpassTextField.attributedPlaceholder = NSAttributedString(string: " Confirm Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(hue: 0.58, saturation: 0.58, brightness: 0.85, alpha: 1.0)])
        
        // Додавання контуру до текстового поля - внизу
        emailTextField.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.6)
        passwordTextField.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.6)
        confirmpassTextField.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.6)
        
        // Додавання відступів до тестовго поля
        self.emailTextField.addPaddingToTextField()
        self.passwordTextField.addPaddingToTextField()
        self.confirmpassTextField.addPaddingToTextField()
    }
    
    @IBAction func registerButtonTapped(_ sender: UIButton) {
        // Перевірка порожніх полів
        guard let email = emailTextField.text, !email.isEmpty,
              let password = passwordTextField.text, !password.isEmpty,
              let confirm = confirmpassTextField.text, !confirm.isEmpty else {
            showAlertError(title: "Error", message: "Fill in all fields")
            return
        }
        
        // Перевірка, що паролі збігаються
        guard password == confirm else {
            showAlertError(title: "Oops", message: "Passwords do not match")
            return
        }
        
        // Якщо всі перевірки пройшли → переходимо на наступний екран вручну
        if let nav = storyboard?.instantiateViewController(withIdentifier: "MainScreenNav") as? UINavigationController {
            nav.modalPresentationStyle = .fullScreen
            present(nav, animated: true)
        }
    }

}
