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
    // 🔑 API ключ для доступу до Unsplash
    let apiKey: String = "dYkegnQ8utJN99Wx5QlZbbBWEbj-rjp4ZFFvj8skI2Y"
    
    // 🌐 Базова URL-адреса сервера
    let url: String = "https://api.unsplash.com"
    
    
    // MARK: 🔹 Основна функція, що виконує запит
    func sendRequest(query: String) {
        
        // 1️⃣ Створюємо базові компоненти URL
        var urlComponents = URLComponents(string: url)
        
        // 2️⃣ Додаємо шлях (endpoint) — у цьому випадку отримуємо випадкове фото
        urlComponents?.path = "/photos/random"
        
        // 3️⃣ Додаємо параметри запиту (query items)
        urlComponents?.queryItems = [
            URLQueryItem(name: "client_id", value: "dYkegnQ8utJN99Wx5QlZbbBWEbj-rjp4ZFFvj8skI2Y"),
            URLQueryItem(name: "query", value: query),  // ключове слово для пошуку
            URLQueryItem(name: "orientation", value: "landscape")
        ]
        
        // 4️⃣ Перевіряємо, що URL успішно сформувався
        guard let url = urlComponents?.url else {
            print("❌ Помилка: невірний URL")
            return
        }
        
        // 5️⃣ Створюємо об'єкт запиту
        var request = URLRequest(url: url)
        request.httpMethod = "GET"  // тип запиту — отримати дані (GET)
   
        
        // 6️⃣ Виконуємо запит через URLSession
        URLSession.shared.dataTask(with: request) { data, resp, err in
            // 7️⃣ Якщо сталася помилка — виводимо її
            guard err == nil else {
                print("❌ Помилка запиту:", err!.localizedDescription)
                return
            }
            
            // якщо помилок немає і дані прийшли
            guard let data else {
                print("⚠️ Даних не отримано")
                return
            }
            // 9️⃣ Перетворюємо отримані дані у текст для перегляду (тільки для тесту)
            print(String(decoding: data, as: UTF8.self))
            
        }.resume()  // 🔚 Не забуваємо викликати resume() — щоб запит виконався!
    }
}

