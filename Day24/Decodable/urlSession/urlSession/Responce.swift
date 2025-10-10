//
//  Responce.swift
//  urlSession
//
//  Created by mac on 10.10.2025.
//

import Foundation


// MARK: 🔹 Декодування JSON у структури
// 1. - Ми дивимося на структуру JSON у документації Unsplash
// 2. - Обираємо поля які нам потрібні та встановлюємо у нашу структуру
// 3. - Витягуємо дані через completion: @escaping (String) ->  Void  у sendRequest()
// 4. - Пробуємо декодувати json у Responce,

// об'єкт { } - структура
// масив об'єктів [ {}, {}, {} ] - масив структур


// 🔸 Головний об’єкт JSON (response з Unsplash виглядає як { "urls": {...} })
struct Responce: Decodable {
    let urls: ImageUrls
}

// 🔸 Вкладений об’єкт, який містить різні розміри зображення
struct ImageUrls: Decodable {
    let regular: String
    let full: String
}
