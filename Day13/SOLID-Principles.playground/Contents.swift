import UIKit

// MARK: - Single Responsibility Principle (SRP)
/// Notes:  Клас має мати лише одну причину для зміни

struct Product {
    let price: Double
}

struct Invoice {
    var products: [Product]
    let id = NSUUID().uuidString
    var discountPercentage: Double = 0
    
    var total: Double {
        let total = products.map( { $0.price }).reduce(0, { $0 + $1 })
        let discountedAmount = total * (discountPercentage / 100)
        return total - discountedAmount
    }
    
    func printInvoice() {
        let printer = InvoicePrinter(invoice: self)
        printer.printInvoice()
    }
    
    func saveInvoice() {
        let persistance = InvoicePersistance(invoice: self)
        persistance.saveInvoice()
    }
}

struct InvoicePrinter {
    let invoice: Invoice
    
    func printInvoice() {
        print("-------------------------")
        print("Invoice id:\(invoice.id)")
        print("Total cost $\(invoice.total)")
        print("Discounts: \(invoice.discountPercentage)")
        print("-------------------------")
    }
}


struct InvoicePersistance {
    let invoice: Invoice
    
    func saveInvoice() {
        // save invoice data locally
    }
}

let products: [Product] = [
    .init(price: 99.99),
    .init(price: 9.99),
    .init(price: 24.99)
]

let invoice = Invoice(products: products, discountPercentage: 20)
//let printer = InvoicePrinter(invoice: invoice)
//let persistance = InvoicePersistance(invoice: invoice)
invoice.printInvoice()

let invoice2 = Invoice(products: products)
//let printer2 = InvoicePrinter(invoice: invoice2)
invoice2.printInvoice()


// MARK: - Open/Closed Principle (OCP)
/// Notes:  Код має бути відкритим для розширення, але закритим для модифікації

struct InvoicePersistanceOCP {
    // persistance = витратливість, invoice - рахунок
    let persistance: InvoicePersistable
    
    func save(invoice: Invoice) {
        persistance.save(invoice: invoice)
    }
    
}

protocol InvoicePersistable {
    func save(invoice: Invoice)
}

struct CoreDataPersistence: InvoicePersistable {
    func save(invoice: Invoice) {
        print("Save invoice to CoreData \(invoice.id)")
    }
}

struct DatabasePersistence: InvoicePersistable {
    func save(invoice: Invoice) {
        print("Save invoice to Firestore \(invoice.id)")
    }
}

let coreDataPersistance = CoreDataPersistence()
let databasePersistance = DatabasePersistence()

let persistanceOCP = InvoicePersistanceOCP(persistance: databasePersistance)

persistanceOCP.save(invoice: invoice)
print("-------------------------")


// MARK: - Liskov Substitution Principle (LSP)
/// Notes:      Підкласи повинні заміняти базові класи без зміни очікуваної поведінки
/// Explain:    Якщо клас B наслідує A, то в будь-якому місці, де потрібен A, можна підставити B

enum APIError: Error {
    case invalidUrl
    case invalidResponse
    case invalidStatusCode
}

struct MockUserService {
    func fetchUser() async throws {
        do {
            throw APIError.invalidResponse
        } catch {
            print("Error: \(error)")
        }
    }
}

let mockUserService = MockUserService()
Task { try await mockUserService.fetchUser() }


// MARK: - Interface Segregation Priciple (ISP)
/// Notes:      Краще багато маленьких специфічних інтерфейсів, ніж один великий універсальний
/// Explain:    Клієнти не повинні реалізовувати методи, які їм не потрібні

protocol GestureProtocol {
    func didTap()
    func didDoubleTap()
    func didLongPress()
}

protocol SingleTapProtocol {
    func didTap()
}
protocol DoubleTapProtocol {
    func didDoubleTap()
}
protocol LongPressProtocol {
    func didLongPress()
}

struct SuperButton: SingleTapProtocol, DoubleTapProtocol, LongPressProtocol {
    func didTap() {
        
    }
    
    func didDoubleTap() {
        
    }
    
    func didLongPress() {
        
    }
}

struct DoubleTapButton: DoubleTapProtocol {
//    func didTap() {}
    
    func didDoubleTap() {
        print("DEBUG: Double tap...")
    }
    
//    func didLongPress() {}
}


// MARK: - Dependency Inversion Principle
/// Notes:      Код має залежати від абстракцій, а не від конкретних реалізаціій
/// Explain:    Використовуємо протоколи / інтерфейси для залежностей, щоб можна було легко заміняти реалізації

protocol PaymentMethod {
    func execute(amount: Double)
}

struct DebitCardPayment: PaymentMethod {
    func execute(amount: Double) {
        print("Debit card payment success for \(amount)")
    }
}

struct StripePayment: PaymentMethod {
    func execute(amount: Double) {
        print("Stripe payment success for \(amount)")
    }
}

struct ApplePayPayment: PaymentMethod {
    func execute(amount: Double) {
        print("ApplePay payment success for \(amount)")
    }
}

// замість цього :
struct Payment {
    var debitCardPayment: DebitCardPayment?
    var stripePayment: StripePayment?
    var applePatPatment: ApplePayPayment?
}

let paymentMethod = DebitCardPayment()
let payment = Payment(debitCardPayment: paymentMethod, stripePayment: nil, applePatPatment: nil)

payment.debitCardPayment?.execute(amount: 100)
payment.applePatPatment?.execute(amount: 100)


// краще використовувати ось це:
struct PaymentDIP {
    let payment: PaymentMethod
    
    func makePayment(amount: Double) {
        payment.execute(amount: amount)
    }
}

let stripe = StripePayment()
let paymentDIP = PaymentDIP(payment: stripe)

paymentDIP.makePayment(amount: 200)
