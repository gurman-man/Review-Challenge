//
//  KeychainManager.swift
//  KeyChain
//
//  Created by mac on 17.10.2025.
//

import Foundation
import Security // Це фреймворк Apple, який надає доступ до Keychain Services API.

protocol KeychainManagerType {
    func getPassword() -> String?
    
    func savePassword(_ password: String) -> Bool
    
    func deletePassword() -> Bool
    
    func updatePassword(_ passwordData: Data) -> Bool
}

class KeychainManager: KeychainManagerType {
    func getPassword() -> String? {
        // Формуємо запит (query) для пошуку в Keychain
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,  // шукаємо пароль
            kSecAttrAccount as String: "user_account",      // Назва акаунта або ключ
            kSecReturnData as String: true,                 // чи повертати самі дані?
        ]
        
        // inout - дозволить потім отримати значення, знайдене у Keychain, через цей параметр.
        var item: AnyObject?
        
        // Шукає у Keychain об’єкт, що відповідає query, і копіює його
        // CFDictionary - C-аналог Swift-словника, потрібен для сумісності із Security API
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        // Якщо статус не успішний — повертаємо nil
        guard status == errSecSuccess else { return nil }
        
        // Конвертуємо отримані дані у String (оскільки Keychain зберігає їх як Data)
        guard let passwordData = item as? Data, let password = String(data: passwordData, encoding: .utf8) else {
            return nil
        }
        
        // Повертаємо знайдений пароль
        return password
    }
    
    
    func savePassword(_ password: String) -> Bool {
        // Перетворюємо пароль у Data, бо Keychain зберігає все у двійковому вигляді
        guard let passwordData = password.data(using: .utf8) else { return false }
        
        // Якщо пароль вже є — просто оновлюємо
        if getPassword() != nil {
            return updatePassword(passwordData)
        } else {
            // Інакше створюємо новий запис у Keychain
            let query: [String: Any] = [
                kSecClass as String: kSecClassGenericPassword,  // тип — звичайний пароль
                kSecAttrAccount as String: "user_account",      // унікальний ключ акаунта
                kSecValueData as String: passwordData           // значення, яке зберігаємо
            ]
            
            // Додаємо новий елемент до Keychain
            let status = SecItemAdd(query as CFDictionary, nil)
            
            // Перевіряємо, чи пароль успішно збережено
            return status == errSecSuccess
        }
    }
    
    
    func deletePassword() -> Bool {
        // Словник описує що саме потрібно видалити
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,  // тип — звичайний пароль
            kSecAttrAccount as String: "user_account",      // унікальний ключ акаунта
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess  // видалення пройшло успішно
    }
    
    
    func updatePassword(_ passwordData: Data) -> Bool {
        // словник - визначає, що саме оновити (за якими критеріями знайти запис у Keychain)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,  // тип — звичайний пароль
            kSecAttrAccount as String: "user_account",      // унікальний ключ акаунта
        ]
        
        // словник - визначає, що саме оновити (які атрибути замінити новими значеннями)
        let updateQuery: [String: Any] = [
            kSecValueData as String: passwordData           // нове значення (оновлений пароль)
        ]
        
        // Функція, яка знаходить елемент за першим словником і оновлює поля згідно з другим
        let status = SecItemUpdate(query as CFDictionary, updateQuery as CFDictionary)
        return status == errSecSuccess
    }

}
