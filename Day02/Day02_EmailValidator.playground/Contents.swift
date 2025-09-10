import UIKit

// Створюємо enum для помилок
enum EmailError: Error {
    case emptyField     // нічого не введено
    case invalidFormat  // невірний формат
}

// Реалізовуємо функцію-валідатор
func validateEmail(_ email: String) -> Result<Bool, EmailError> {
    // Якщо пусте поле
    if email.isEmpty {
        return .failure(.emptyField)
    }
    
    // Проста перевірка чи рядок виглядає як email
    
    let regex = #"^\S+@\S+\.\S+$"#   // шаблон
    /*
     
    ^   — початок рядка.
    \S+ — одна або більше непробільних літер/символів (S = not space).
    @   — обов’язковий символ @.
    \S+ — знову кілька непробільних символів (частина після @).
    \.  — крапка (перед доменом).
    \S+ — кілька непробільних символів (домен, наприклад com).
    $   — кінець рядка.
     
    Тобто ми описали:
    [щось без пробілів]@[щось без пробілів].[щось без пробілів]
     
    */
    
    if email.range(of: regex, options: .regularExpression) == nil {
        return .failure(.invalidFormat)
    }
    
    return .success(true)
}

// Використання (створення екземпляру з різними emails і перевірка їх на валідність)
let emails: [String] = ["", "megaluks5864", "user@mail.com"]

for email in emails {
    switch validateEmail(email) {
    case .success:
        print("\(email) ✅ is valid format.")
    case .failure(let error):
        switch error {
        case .emptyField:
            print("⚠️ Empty email.")
        case .invalidFormat:
            print("\(email) ❌ is invalid format")
        }
    }
}

print("\n")

// Сторення масиву (Array)
let fruits = ["Apple", "Banana", "Pineapple"]
for fruit in fruits {
    print("Fruit: \(fruit)")
}

print("\n")

// Створення словника (Dictionary)
let userEmails: [String: Bool] = [
    "google.com"            : false,
    "user@gmail.com"    : true
]

for(email, isValid) in userEmails {
    print("\(email): \(isValid ? "valid" : "invalid")")
}

print("\n")

// Cтворення множини (Set)
let colors = Set(["red", "yellow", "sky-blue", "green", "yellow", "pink", "red"])
for color in colors {
    print("Color: \(color)")
}

print("\n")

// Створення кортежу (Tuple)
let user = (name: "Max", email: "megaluks5864@gmail.com", age: 25)
print(user.name)
print(user.email)
print(user.2)

print("\n")

// Створення перерахування з необробленим значенням (Enum iз row values)
// Enum - перелік повязаних значень
enum Status: String {
    case active = "Active"
    case inactive = "Inactive"
}

let status = Status.inactive
print(status.rawValue)
