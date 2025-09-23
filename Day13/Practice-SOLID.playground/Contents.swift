import UIKit

// Practice SOLID Principles

// MARK: SRP - Single Responsibility
struct Devices {
    var name: String
    var price: Double
}

class Order {
    var devices: [Devices]
    
    init(devices: [Devices]) {
        self.devices = devices
    }
}

// Окремий клас для підрахунку суми
class OderCalculator {
    
    func total(for order: Order) -> Double {
        return order.devices.map { $0.price}.reduce(0, +)
    }
}

// Окремий клас для друку чеку
class ReceiptPrinter {
    func printOrderReceipt(for order: Order, total: Double) {
        print("Order Receipt: ")
        for device in order.devices {
            print("- \(device.name): \(device.price)$")
        }
        print("Total: \(total)$")
    }
}


// Використання
let devices = [
    Devices(name: "iPhone17", price: 800),
    Devices(name: "MacBook Air", price: 600)
]

let order = Order(devices: devices)
let calculator = OderCalculator()
let printer = ReceiptPrinter()

let total = calculator.total(for: order)
printer.printOrderReceipt(for: order, total: total)


// MARK: OCP - Open/Closed
// Ідея:
/*
    - Нові знижки додаються як нові класи, що реалізуються DiscountPolicy
    - Checkout не змінюється взагалі
*/

// Усі види знижок реалізуюють цей протокол
protocol DiscountPolicy {
    func apply(to amount: Double) -> Double
    
}

// Клас без знижкм
class NoDiscount: DiscountPolicy {
    func apply(to amount: Double) -> Double {
        return amount
    }
}

// Клас з відсотковою знижкою
class PercentageDiscount: DiscountPolicy {
    let percent: Double // наприклад 10%
    
    init(percent: Double) {
        self.percent = percent
    }
    
    func apply(to amount: Double) -> Double {
        return amount - (amount * percent / 100)
    }
}

class Checkout {
    let discountPolicy: DiscountPolicy
    
    init(discountPolicy: DiscountPolicy) {
        self.discountPolicy = discountPolicy
    }
    
    func total(for amount: Double) -> Double {
        return discountPolicy.apply(to: amount)
    }
}


class fixAmountDiscount: DiscountPolicy {
    let fixPercentDiscount: Double
    
    func apply(to amount: Double) -> Double {
        // використовується функція max, яка повертає більше з двох чисел - max(число1, число2)
        // це гарантує що ціна після фіксованої знижки буде 0, а не від'ємною
        return max(amount - fixPercentDiscount, 0)
    }
    
    init(fixPercentDiscount: Double) {
        self.fixPercentDiscount = fixPercentDiscount
    }
    
}


// Використання
let noDiscount = Checkout(discountPolicy: NoDiscount())
print("No discount: ", noDiscount.total(for: 100))

let percentDiscount = Checkout(discountPolicy: PercentageDiscount(percent: 25))
print("25% discount: ", percentDiscount.total(for: 100))

let fixedDiscount = Checkout(discountPolicy: fixAmountDiscount(fixPercentDiscount: 10))
print("Fixed 10$ discount: ", fixedDiscount.total(for: 100))
print("--------------------------")

// MARK: LSP - Liskov Subtitution

/*
protocol Shape {
    func area() -> Double
}

struct Square: Shape {
    var side: Double
    
    func area() -> Double {
        return side * side
    }
    
}

struct Rectangle: Shape {
    var width: Double
    var height: Double
    
    func area() -> Double {
        return width * height
    }
}

func printArea(of shape: Shape) {
    print("Area: \(shape.area())")
}

let rectangle: Shape = Rectangle(width: 4.0, height: 5.0)
let square: Shape = Square(side: 5.0)
*/

// MARK: ISP - Interface Segregation

protocol Device {
    func call()
    func sendMessage()
    func takePhoto()
}

protocol Call {
    func call()
}
protocol SendMessage {
    func sendMessage()
}
protocol TakePhoto {
    func takePhoto()
}

struct Smartphone: Call, SendMessage, TakePhoto {
    var name: String
    
    func call() {
        print("\(name) - calling")
    }
    
    func sendMessage() {
        print("\(name) - sending message")
    }
    
    func takePhoto() {
        print("\(name) - take a photo")
    }
}

struct Camera: TakePhoto {
    var name: String
    
    func takePhoto() {
        print("\(name) - take a photo")
    }
}

let camera = Camera(name: "Sony MX54")
camera.takePhoto()

let smartphone = Smartphone(name: "iPhone17")
smartphone.call()
smartphone.sendMessage()
smartphone.takePhoto()
print("--------------------------")


// MARK: DIP - Dependency Inversion
protocol Logger {
    func log(_ message: String)
}

class ConsoleLonger: Logger {
    func log(_ message: String) {
        print("Console log: \(message)")
    }

}

class FileLogger: Logger {
    func log(_ message: String) {
        // умовно збережемо у файл
        // код для запису у файл
        print("File log: \(message)")
    }
}


class UserService {
    let logger: Logger
    
    init(logger: Logger) {
        self.logger = logger
    }
    
    func addUser(name: String) {
        // ... якась логіка додавання користувача
        logger.log("User \(name) added.")
    }
    
    func deleteUser(name: String) {
        // ... якась логіка видаленння користувача
        logger.log("User \(name) deleted.")
    }
}

// Тестуємо:
let consoleLogger = ConsoleLonger()
let userService1 = UserService(logger: consoleLogger)
userService1.addUser(name: "Max")
userService1.deleteUser(name: "Max")

let fileLogger = FileLogger()
let userService2 = UserService(logger: fileLogger)
userService2.addUser(name: "Anna")
userService2.deleteUser(name: "Anna")


