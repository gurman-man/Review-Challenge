# SOLID Principles (Swift)

🔹 **Що таке SOLID**  
Це 5 принципів об’єктно-орієнтованого проєктування, які допомагають робити код:
- гнучкішим
- легшим у підтримці
- придатним до розширення без великих змін

**Абревіатура:**
- **S** – Single Responsibility Principle
- **O** – Open/Closed Principle
- **L** – Liskov Substitution Principle
- **I** – Interface Segregation Principle
- **D** – Dependency Inversion Principle

---

## 1️⃣ SRP — Single Responsibility Principle
Клас має мати лише одну причину для зміни.  
Один клас = одна роль. Не змішуємо логіку, що відноситься до різних сфер.

```swift
// ❌ Погано: клас робить дві речі — зберігає та відправляє
class UserManager {
    func saveUser(_ user: User) { /* save to DB */ }
    func sendWelcomeEmail(to user: User) { /* send email */ }
}

// ✅ Добре: розділяємо відповідальності
class UserStorage {
    func saveUser(_ user: User) { /* save to DB */ }
}

class UserNotifier {
    func sendWelcomeEmail(to user: User) { /* send email */ }
}
```

## 2️⃣ OCP — Open/Closed Principle
Код має бути відкритим для розширення, але закритим для модифікації.
Додаємо новий функціонал без зміни старого коду. Використовуємо протоколи, наслідування, композицію.

```swift
protocol PaymentMethod {
    func pay(amount: Double)
}

class CreditCardPayment: PaymentMethod {
    func pay(amount: Double) { print("Paying \(amount) by card") }
}

class PayPalPayment: PaymentMethod {
    func pay(amount: Double) { print("Paying \(amount) by PayPal") }
}

class Checkout {
    private let paymentMethod: PaymentMethod
    init(paymentMethod: PaymentMethod) { self.paymentMethod = paymentMethod }
    
    func process(amount: Double) {
        paymentMethod.pay(amount: amount)
    }
}

// ✅ додаємо новий спосіб (ApplePay) не чіпаючи Checkout
```


## 3️⃣ LSP — Liskov Substitution Principle
Підкласи повинні заміняти базові класи без зміни очікуваної поведінки.
Якщо клас B наслідує A, то в будь-якому місці, де потрібен A, можна підставити B.

```swift
class Bird {
    func fly() {
        print("Flying")
    }
}

class Sparrow: Bird { } // ✅ може літати
// class Ostrich: Bird { } // ❌ не може літати

// Краще:
protocol Bird {
    func makeSound()
}

protocol FlyingBird: Bird {
    func fly()
}

class Sparrow: FlyingBird {
    func makeSound() { print("Chirp") }
    func fly() { print("Flying") }
}

class Ostrich: Bird {
    func makeSound() { print("Boom") }
}
```
Тепер не порушуємо очікування: Ostrich не має методу fly().


## 4️⃣ ISP — Interface Segregation Principle
Краще багато маленьких специфічних інтерфейсів, ніж один великий універсальний.
Клієнти не повинні реалізовувати методи, які їм не потрібні.

```swift
// ❌ Погано: одна велика протокол-збірка
protocol Worker {
    func work()
    func eat()
}

class Robot: Worker {
    func work() { print("Work") }
    func eat() { /* не потрібно */ }
}

// ✅ Добре: розділяємо
protocol Workable {
    func work()
}
protocol Eatable {
    func eat()
}

class Human: Workable, Eatable {
    func work() { print("Working") }
    func eat() { print("Eating") }
}

class Robot: Workable {
    func work() { print("Working without eating") }
}
```

## 5️⃣ DIP — Dependency Inversion Principle
Код має залежати від абстракцій, а не від конкретних реалізацій.
Використовуємо протоколи/інтерфейси для залежностей, щоб можна було легко заміняти реалізації.

```swift
protocol Database {
    func save(data: String)
}

class MySQLDatabase: Database {
    func save(data: String) { print("Save to MySQL") }
}

class App {
    private let database: Database
    init(database: Database) {
        self.database = database
    }
    
    func run() {
        database.save(data: "User data")
    }
}

// ✅ легко змінити на іншу базу
let app = App(database: MySQLDatabase())
app.run()
```

**📝 Підсумок у Swift-термінах**
**SRP** – Структури, класи, протоколи мають одну роль.
**OCP** – Розширюй через протоколи й наслідування.
**LSP** – Стеж, щоб підкласи/реалізації протоколів не ламали очікування.
**ISP** – Краще кілька дрібних протоколів.
**DIP** – Працюй через протоколи, а не через конкретні класи.
