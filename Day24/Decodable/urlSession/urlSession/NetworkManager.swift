//
//  NetworkManager.swift
//  urlSession
//
//  Created by mac on 09.10.2025.
//

import Foundation

// MARK: Що потрібно мати перед тим, як робити запит на API
//
//  1️⃣ URL — адреса сервера або кінцевої точки API (endpoint), куди йде запит.
//  2️⃣ API ключ (token), якщо потрібна авторизація (наприклад Unsplash API).
//  3️⃣ Параметри запиту (query, orientation, page тощо).
//  4️⃣ Виконати запит через URLSession і обробити результат.

// Параметри - /?client_id=apiKey&query
// Шлях - photos/random

class NetworkManager {
    let apiKey: String = "dYkegnQ8utJN99Wx5QlZbbBWEbj-rjp4ZFFvj8skI2Y"
    let url: String = "https://api.unsplash.com"
    
    
    // MARK: 🔹 Основна функція, що виконує запит
    func sendRequest(query: String, completion: @escaping (String) -> Void) {
        // completion — замикання, через яке ми передаємо результат (url картинки)
        
        var urlComponents = URLComponents(string: url)
        
        urlComponents?.path = "/search/photos"  // endpoint
        
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "dYkegnQ8utJN99Wx5QlZbbBWEbj-rjp4ZFFvj8skI2Y"),
            URLQueryItem(name: "query", value: query),  // ключове слово для пошуку
            URLQueryItem(name: "orientation", value: "landscape")
        ]
        
        guard let url = urlComponents?.url else {
            print("❌ Помилка: невірний URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"  // тип запиту — отримати дані (GET)
   
    
        URLSession.shared.dataTask(with: request) { data, resp, err in
            guard err == nil else {
                print("❌ Помилка запиту:", err!.localizedDescription)
                return
            }
            
            guard let data else {
                print("⚠️ Даних не отримано")
                return
            }
            
            // беремо наш json (data) та пробуємо декодувати у нашу структуру Responce
            do {
                let result = try JSONDecoder().decode(Responce.self, from: data)
                completion(result.urls.regular)   // витягуємо посилання на картинку
            } catch {
                print("Error: \(error.localizedDescription)")
            }
            
        }.resume()
    }
}

