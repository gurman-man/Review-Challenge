//
//  CurrencyManager.swift
//  CurrencyConverter
//
//  Created by mac on 13.10.2025.
//

import Foundation

enum NetWorkError: LocalizedError {
    case badURL
    case badResponse
    case decodingFailed
    case noValue
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .badURL:
            return "❌ Invalid URL"
        case .badResponse:
            return "⚠️ Bad response from server"
        case .decodingFailed:
            return "🚫 Failed to decode data"
        case .noValue:
            return "No conversion value found"
        case .unknown:
            return "unknown error"
        }
    }
}

class CurrencyManager {
    private let apiKey = "cur_live_FXQIEp5zVnsBixo5v3vqTrKyFzNKc8RJClNhwI4C"
    let url = "https://api.currencyapi.com"
    
    // MARK: - Головна функція
    // Формує URL -> Надсилає запит -> Декодує JSON -> Повертає результат асинхронно через completion
    // Тип Result<Double, Error> — це вбудований enum у Swift -> він має два кейси :
//  case success(Success)
//  case failure(Failure)
    func convertCurrency(from base: String, to target: String, amount: Double, completion: @escaping (Result<Double, Error>) -> Void) {
        
        // 🔹 1. Формування URL
        var components = URLComponents(string: url)
        components?.scheme = "https"                     // протокол
        components?.host = "api.currencyapi.com"         // домен
        components?.path = "/v3/latest"                  // endpoint
        
        // Параметри запиту (query items)
        components?.queryItems = [
            URLQueryItem(name: "base_currency", value: base),
            URLQueryItem(name: "currencies", value: target)
        ]
        
        
        // 🔹 2. Перевірка на правильний URL
        guard let url = components?.url else {
            print(NetWorkError.badURL.localizedDescription)
            return
        }
        
        // 🔹 3. Створення запиту
        var request = URLRequest(url: url)
        request.httpMethod = "GET"  // визначає тип запиту (GET) -> отримати дані з API
        request.setValue(apiKey, forHTTPHeaderField: "apikey")  // додає заголовок із твоїм ключем -> щоб сервер знав, хто робить запит і дозволив доступ
        
        // 🔹 4. Виконання запиту
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let err = error {
                completion(.failure(err))
                return
            }
            
            guard let data else {
                completion(.failure(NetWorkError.noValue))
                return
            }
            
            // Перевірка статусу відповіді
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NetWorkError.badResponse))
                return
            }
            
            // 🔹 5. Декодування JSON -> отримуємо нашу відповідь -> результат запиту
            do {
                let decoded = try JSONDecoder().decode(CurrencyResponse.self, from: data)
                if let rate = decoded.data[target]?.value {
                    let converted = amount * rate // множимо на cуму(початкова цифра)
                    completion(.success(converted))
                } else {
                    completion(.failure(NetWorkError.noValue))
                }
            } catch {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("❌ JSON decoding error. JSON:\n\(jsonString)")
                }
                
                completion(.failure(NetWorkError.decodingFailed))
            }
        }.resume()
        
    }
}
