import UIKit

// Створення власних помилок
enum UserError: Error {
    case notFound
    case invalidID
}

// Модель
struct User {
    var name: String
    var id: Int
    
    init(name: String, id: Int) {
        self.name = name
        self.id = id
    }
}

// База користувачів
let users = [
    User(name: "Max", id: 1),
    User(name: "Yarina", id: 2)
]

// Функція, що кидає помилки
func fetchUser(id: Int) throws -> String {
    guard id > 0 else {
        throw UserError.invalidID
    }
    // пошук користувача
    guard let user = users.first(where: { $0.id == id }) else {
        throw UserError.notFound
    }
    return "User name: \(user.name)."
}

// Використання
do {
    let user = try fetchUser(id: 7)
    print(user)
} catch UserError.notFound {
    print("User not found")
} catch UserError.invalidID {
    print("User's id is incorrect!")
} catch {
    print("Other error \(error)")
}


// Обробка через try? і try!
let user = try fetchUser(id: 1)
print(user)

// Комбінування з optional binding
if let user = try? fetchUser(id: 9) {
    print(user)
}
print("------------------------------")

// Додаткова практика
func loadUsers(ids: [Int]) -> [Result<String, UserError>] {
    var results: [Result<String, UserError>] = []
    
    for id in ids {
        do {
            let name = try fetchUser(id: id)
            results.append(.success(name))
        } catch let error as UserError {
            results.append(.failure(error))
        } catch {
            results.append(.failure(.notFound))
        }
    }
    return results
}

let results = loadUsers(ids: [1, 7, 2])
for result in results {
    switch result {
    case .failure(let error):
        print("X \(error)")
    case .success(let userString):
        print("Correct: \(userString)")
    }
}
