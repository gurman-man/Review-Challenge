//
//  AuthDelegate.swift
//  LoginRegisterApp
//
//  Created by mac on 29.09.2025.
//

import UIKit

protocol AuthDelegate: AnyObject {
    func didFinishAuth()       // Для успішного входу/реєстрації
    func showAlert(title: String, message: String) // Для показу alert на весь екран
}

