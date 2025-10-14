//
//  ApiManager.swift
//  urlSession
//
//  Created by mac on 13.10.2025.
//

// 
import Foundation

class AIManager {
    let url = "https://bothub.chat/api/v2/openai/v1/images/generations"
    private let apiKey = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjdhNWVmMzI0LTc1NmUtNDVlOC04YWYxLTFlMWNkMDRkMDE1NyIsImlzRGV2ZWxvcGVyIjp0cnVlLCJpYXQiOjE3MzUzOTAЗNjIsImV4cCI6MjA1MDk2Njc2Mn0.xL2fhtLOtHp_K4Xn_bEAhuKgnRwYlUGwaRk-XxirgdY"
    
    func generateImage(prompt: String, completion: @escaping (Result<BotHubResponceData,Error>) -> Void) {
        guard let url = URL(string: url) else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body = RequestModel(prompt: prompt)
        do {
            let bodyReq = try JSONEncoder().encode(body)
            request.httpBody = bodyReq
        } catch {
            print(error.localizedDescription)
        }
        
        URLSession.shared.dataTask(with: request) { data, _, err in
            guard err == nil else {
                completion(.failure(err!))
                return
            }
            
            guard let data else { return }
            if let jsonString = String(data: data, encoding: .utf8) {
                print("📦 SERVER RESPONSE:\n\(jsonString)")
            }
            
            do {
                let image = try JSONDecoder().decode(BotHubResponce.self, from: data)
                completion(.success(image.data[0]))
            } catch {
                completion(.failure(error))
            }
            
        }.resume()
    }
    
}

struct RequestModel: Encodable {
    let model: String = "dall-e-3"
    let prompt: String
    let n: Int = 1
    let size: String = "1024x1024"
}

struct BotHubResponce: Decodable {
    let data: [BotHubResponceData]
}

struct  BotHubResponceData: Decodable {
    let revised_prompt: String
    let url: String
}
