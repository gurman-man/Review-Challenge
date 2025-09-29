//
//  ViewController.swift
//  LoginRegisterApp
//
//  Created by mac on 28.09.2025.
//

import UIKit

class ViewController: UIViewController, AuthDelegate {
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var loginSegmentView: UIView!
    @IBOutlet weak var registerSegmentView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        // Показати loginContainerView по дефолту
        self.view.bringSubviewToFront(loginSegmentView)
    }
    
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.view.bringSubviewToFront(loginSegmentView)
        case 1:
            self.view.bringSubviewToFront(registerSegmentView)
        default:
            break
        }
    }
    
    
    func setupUI() {
        
        // Segment Text Color
        let titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
        segment.setTitleTextAttributes(titleTextAttributes, for: .normal)
    }
    
    
    func didFinishAuth() {
        // Створюємо контролер, який ти додав у сторіборд
        if let mainVC = storyboard?.instantiateViewController(identifier: "MainScreenVC") as? MainScreenVC {

            // обгортаємо в NavigationController, якщо хочемо navigation bar
            let nav = UINavigationController(rootViewController: mainVC)
            nav.modalPresentationStyle = .fullScreen

            // показуємо
            present(nav, animated: true)
        }
    }
    
    func showAlert(title: String, message: String) {
        // ⚡ Важливо: викликаємо на головному потоці
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alert, animated: true)
        }
    }
    
    
    // Повідомляємо батька(ViewController) про успішний логін/реєстрацію та передаємо їм роль
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let loginVC = segue.destination as? loginSegmentViewController {
            loginVC.delegate = self
        }
        if let registerVC = segue.destination as? registerSegmentViewController {
            registerVC.delegate = self
        }
    }
    
}
