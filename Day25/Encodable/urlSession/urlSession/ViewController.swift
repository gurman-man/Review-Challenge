//
//  ViewController.swift
//  urlSession
//
//  Created by mac on 09.10.2025.
//

import UIKit

class ViewController: UIViewController {
    private let networkManager = NetworkManager()
    private let aiManager = AIManager()
    
    // 🔹 UIImageView для показу фото
    private lazy var imageUIimage: UIImageView = {
        $0.frame.size = CGSize(width: 300, height: 300)
        $0.center = view.center
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
    }(UIImageView())
    
    
    private lazy var addBut: UIButton = {
        $0.frame.size = CGSize(width: 70, height: 70)
        $0.layer.cornerRadius = 30
        $0.backgroundColor = .black
        $0.setImage(UIImage(systemName: "plus"), for: .normal)
        $0.tintColor = .white
        $0.frame.origin = CGPoint(x: view.frame.width - 100, y: view.frame.height - 100)
        return $0
    }(UIButton(primaryAction: action))
    
    private lazy var textField: UITextField = {
        $0.placeholder = "Search..."
        $0.frame.size = CGSize(width: view.frame.width - 150, height: 50)
        $0.frame.origin = CGPoint(x: 30, y: addBut.frame.maxY - 60)
        $0.backgroundColor = .lightGray
        $0.layer.cornerRadius = 10
        $0.leftViewMode = .always
        $0.leftView = UIView(frame: CGRect(origin: .zero, size: CGSize(width: 10, height: 0)))
        return $0
    }(UITextField())
    
    private lazy var action: UIAction = UIAction { [weak self] _ in
        guard let self = self else { return }
        guard let text = textField.text else { return }
        
        print("Start loading")
        aiManager.generateImage(prompt: text) { result in
            switch result {
            case .success(let success):
                let url = success.url
                guard let url = URL(string: url) else { return }
                self.imageUIimage.load(url: url)
                print("Stop loading")
            case .failure(let failure):
                print(failure.localizedDescription)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageUIimage)
        view.addSubview(addBut)
        view.addSubview(textField)
        
        // 🔸 Викликаємо запит до API
        networkManager.sendRequest(query: "car") { [weak self] urlString in
            guard let self = self else { return }   // Якщо ViewController зник — просто вийти з коду
            guard let urlString = URL(string: urlString) else { return }
            
            // 🔹 Завантажуємо зображення у фоновому потоці
            imageUIimage.load(url: urlString)
        }
    }
}

// MARK: 🔹 Розширення для UIImageView, відповідає за завантаження картинки з цього URL у саму картинку.
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global(qos: .utility).async { [weak self] in
            // 1️⃣ Завантажуємо дані картинки
            if let data = try? Data(contentsOf: url) {
                // 2️⃣ Перетворюємо в UIImage
                if let image = UIImage(data: data) {
                    // 3️⃣ Показуємо на головному потоці (UI завжди на main!)
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}

