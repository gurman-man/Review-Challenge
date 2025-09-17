import UIKit

// Створи модель користувача
struct User {
    public let name: String
    public let email: String
    private let password: String // приховаємо від сторонніх
    
    init(name: String, email: String, password: String) {
        self.name = name
        self.email = email
        self.password = password
    }
    
    // допоміжний метод для перевірки пароля
    func checkPassword(_ input: String) -> Bool {
        return input == password
    }
}

// Створи UserManager
class UserManager {
    nonisolated(unsafe) private static var users: [User] = []
    
    lazy var heavyData: [String] = {
        print("Loadind data...")
        return ["Data1", "Data2", "Data3"]
    }()
    
    static func login(email: String, password: String) -> String {
        if let user = Self.users.first(where: { $0.email == email }) {
            if user.checkPassword(password) {
                return "Login successful for \(user.name)"
            } else {
                return "Password is incorect for \(user.name)"
            }
        } else {
            return "User with email \(email) not found"
        }
    }
    
    // метод для реєстрації новго користувачі
    static func registration(name: String, email: String, password: String) -> String {
        let newUser = User(name: name, email: email, password: password)
        UserManager.users.append(newUser)
        return "User \(name) registered successfully!"
    }
    
    // метод для демонстрації self + lazy
    func showHeavyData() {
        print(self.heavyData)
    }
}

// Реєструємо користувачів
UserManager.registration(name: "Max", email: "max@gmail.com", password: "123")
UserManager.registration(name: "Anna", email: "anna@gmail.com", password: "321")
UserManager.registration(name: "John", email: "john@gmail.com", password: "abc")

// Перевіряємо
print(UserManager.login(email: "max@gmail.com", password: "123"))
print(UserManager.login(email: "annaafa@gmail.com", password: "321"))
print(UserManager.login(email: "john@gmail.com", password: "bcafds"))

// Демонстрація lazy
let manager = UserManager()
print("Before to get access to heavyData")
manager.showHeavyData()
manager.showHeavyData() // тут повторюється

