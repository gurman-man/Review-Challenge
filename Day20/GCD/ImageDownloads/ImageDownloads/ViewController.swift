//
//  ViewController.swift
//  ImageDownloads
//
//  Created by mac on 02.10.2025.
//

import UIKit

class ViewController: UIViewController {
    // MARK: - Outlets
    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var imageView3: UIImageView!

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    // URL-адреси картинок
    let imageURLs = [
        URL(string: "https://picsum.photos/1920/1080")!,
        URL(string: "https://picsum.photos/1920/1080")!,
        URL(string: "https://picsum.photos/1920/1080")!
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    // MARK: - GCD
    func loadImagesWithGCD() {
        let imageViews = [imageView1, imageView2, imageView3]
        activityIndicator.startAnimating()                          // стартуємо індикатор
        view.isUserInteractionEnabled = false                       // блокуємо взаємодію з користувачем
        let startTime = Date()                                      // відмічаємо початок завантаження
        
        let dispatchGroup = DispatchGroup()                         // створюємо групу задач
        
        for (index, url) in imageURLs.enumerated() {
            dispatchGroup.enter()                                   // повідомляємо групу, що задача почалася
            
            // Використовуємо URLSession замість Data(contentsOf:)
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data, let image = UIImage(data: data) {      // оновлюємо UI на головному потоці
                    DispatchQueue.main.async {
                        if index < imageViews.count { // безпечний доступ
                            imageViews[index]?.image = image
                        }
                        dispatchGroup.leave()                        // повідомляємо, що задача завершилася
                    }
                } else {
                    print("GCD error: \(error?.localizedDescription ?? "unknown")")
                    dispatchGroup.leave()                           // навіть при помилці виходимо з групи
                }
            }.resume()
        }
        
        dispatchGroup.notify(queue: .main) {                        // коли всі задачі завершаться
            self.activityIndicator.stopAnimating()                  // зупиняємо індикатор
            self.view.isUserInteractionEnabled = true               // розблоковуємо UI
            let endTime = Date()
            let duration = endTime.timeIntervalSince(startTime)
            print("GCD завантаження тривало \(duration) секунд")
        }
    }
    
    // MARK: - Async/Await
    func loadImagesWithAsyncAwait() async {
        let imageViews = [imageView1, imageView2, imageView3]
        await MainActor.run {
            activityIndicator.startAnimating()               // стартуємо індикатор
            view.isUserInteractionEnabled = false            // блокуємо UI
        }
        let startTime = Date()                               //Запам’ятовуємо початковий чаc
        
        await withTaskGroup(of: (Int, UIImage?).self) { group in
            for (index, url) in imageURLs.enumerated() {
                group.addTask {
                    do {
                        let (data, _) = try await URLSession.shared.data(from: url)
                        // Асинхронно завантажуємо дані картинки з інтернету.
                        let image = UIImage(data: data)
                        // Перетворюємо отримані дані на картинку.
                        return (index, image)
                        // Повертаємо індекс і картинку як результат задачі.
                    } catch {
                        print("Async error: \(error)")
                        return (index, nil)
                    }
                }
            }
            
            for await (index, image) in group {
                await MainActor.run {
                    if index < imageViews.count {
                        imageViews[index]?.image = image
                    }
                }
            }
        }
        
        await MainActor.run {
            activityIndicator.stopAnimating()       // зупиняємо індикатор
            view.isUserInteractionEnabled = true    // розблоковуємо UI
            let endTime = Date()
            let duration = endTime.timeIntervalSince(startTime)
            print("Async/Await завантаження тривало \(duration) секунд")
        }
    }
    
    
    // MARK: - IBActions
    @IBAction func downloadWithGCDTapped(_ sender: UIButton) {
        loadImagesWithGCD()
    }
    
    @IBAction func downloadWithAsyncAwaitTapped(_ sender: UIButton) {
        Task {
            await loadImagesWithAsyncAwait()
        }
    }
    
    @IBAction func clearTapped(_ sender: UIButton) {
        [imageView1, imageView2, imageView3].forEach { $0?.image = nil }
    }
    
}

