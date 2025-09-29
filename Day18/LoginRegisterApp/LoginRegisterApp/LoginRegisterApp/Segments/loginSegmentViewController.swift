//
//  loginSegmentViewController.swift
//  LoginRegisterApp
//
//  Created by mac on 28.09.2025.
//

import UIKit

class loginSegmentViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
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
        
        // Додавання контуру до текстового поля - внизу
        emailTextField.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.6)
        passwordTextField.addBottomBorderWithColor(color: UIColor.lightGray, width: 0.6)
        
        // Додавання відступів до тестовго поля
        self.emailTextField.addPaddingToTextField()
        self.passwordTextField.addPaddingToTextField()
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard validateFieldsNotEmpty(emailTextField, passwordTextField) else { return }
        
        if validateLogin(email: emailTextField.text, password: passwordTextField.text) {
            // Якщо всі перевірки пройшли → переходимо на наступний екран вручну
            if let nav = storyboard?.instantiateViewController(withIdentifier: "MainScreenNav") as? UINavigationController {
                nav.modalPresentationStyle = .fullScreen
                present(nav, animated: true)
            }
        } else {
            showAlertError(title: "Error", message: "Incorrect email or password")
        }
    }
}


extension UIView {
    func addBottomBorderWithColor(color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.width - 25, height: width)
        self.layer.addSublayer(border)
    }
}


extension UITextField {
    func addPaddingToTextField() {
        let paddingView: UIView = UIView.init(frame: CGRect(x: 0, y: 0, width: 8, height: 0))
        self.leftView = paddingView
        self.leftViewMode = .always
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
