//
//  Ext.swift
//  LoginRegisterApp
//
//  Created by mac on 29.09.2025.
//

import UIKit

extension UIViewController {
    // MARK: - Валідація Email та Пароля
        func validateLogin(email: String?, password: String?) -> Bool {
            guard let email = email, !email.isEmpty,
                  let password = password, !password.isEmpty else { return false }
            return email.contains("@") && password.count >= 6
        }
    
    // MARK: - Показати Алерт
    @objc func showAlertError(title: String, message: String) {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    
    // MARK: - Перевірка, що текстові поля не пусті
      func validateFieldsNotEmpty(_ fields: UITextField...) -> Bool {
          for field in fields {
              if let text = field.text, text.isEmpty {
                  showAlertError(title: "Error", message: "Fill all lines")
                  return false
              }
          }
          return true
      }
}
