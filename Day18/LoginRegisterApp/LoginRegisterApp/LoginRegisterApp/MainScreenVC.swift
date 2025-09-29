//
//  HomeVC.swift
//  LoginRegisterApp
//
//  Created by mac on 29.09.2025.
//

import UIKit

class MainScreenVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Main"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(logoutTapped))
    }
    
    @objc func logoutTapped() {
        dismiss(animated: true)
    }
}
