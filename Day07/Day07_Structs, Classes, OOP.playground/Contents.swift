import UIKit

// Створення моделей e-commerce

// Product – struct, бо незалежні копії
struct Product {
    let id: Int
    let name: String
    var price: Double
    
    mutating func applyDiscount(percent: Double) {
        let discount = self.price * percent / 100.0
        self.price -= discount
    }
}

class Person {
    var name: String
    var email: String
    
    init(name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    func describe() -> String {
        return "Person: \(name), email: \(email)"
    }
}


// Order – class, бо є посилання на користувача та продукти
class Order {
    let id: Int
    let user: User
    var products: [Product]
    var isPaid: Bool
    
    init(id: Int, user: User, products: [Product], isPaid: Bool) {
        self.id = id
        self.user = user
        self.products = products
        self.isPaid = isPaid
    }
    
    func calculateFinalPrice() -> Double {
        var total = 0.0             // зміна для підрахунку
        
        for product in products {   // проходимося по кожному продукту
            total += product.price  // додаємо ціну
        }
        return total                // повертаємо суму
    }
}

// User – class, бо може змінювати стан (баланс, список замовлень)
class User: Person {
    let id: Int
    var cart: [Product] = []
    
    init(id: Int, name: String, email: String, cart: [Product]) {
        self.id = id
        self.cart = cart
        super.init(name: name, email: email)
    }
    
    func addProduct(_ product: Product) {
        cart.append(product)
    }
    
    override func describe() -> String {
        return "User: \(name) with id\(id)."
    }
    
}


// 1. Сторюємо продукти
var product1 = Product(id: 1, name: "iPhone", price: 800)
var product2 = Product(id: 2, name: "AirPods", price: 250)

// змінюємо ціну зі знижкою (mutating)
print("Product: \(product1.name) - original price: \(product1.price)$")
print("Product: \(product2.name) - original price: \(product2.price)$\n")

product1.applyDiscount(percent: 10) // наприклад, -10%
product2.applyDiscount(percent: 20) // -20%

print("Product: \(product1.name) - price after discount: \(product1.price)$")
print("Product: \(product2.name) - price after discount: \(product2.price)$\n")

// 2. Створюємо користувача
let user = User(id: 1, name: "Max", email: "max@gmail.com", cart: [])

// Додаємо продукти в кошик користувача
user.addProduct(product1)
user.addProduct(product2)


// 3. Cтворюємо замовлення на основі користувачі і продуктів
let order = Order(id: 1, user: user, products: user.cart, isPaid: false)

// Підраховуємо суму замовлення
let totalPrice = order.calculateFinalPrice()
print("Order amount: \(totalPrice)$")
