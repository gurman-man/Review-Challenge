//
//  ViewController.swift
//  urlSession
//
//  Created by mac on 09.10.2025.
//

import UIKit

class ViewController: UIViewController {
    private let networkManager = NetworkManager()
    
    // 🔹 UIImageView для показу фото
    private lazy var imageUIimage: UIImageView = {
        $0.frame.size = CGSize(width: 200, height: 200)
        $0.center = view.center
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        return $0
        
    }(UIImageView())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(imageUIimage)
        
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

