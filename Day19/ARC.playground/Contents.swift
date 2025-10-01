import UIKit

// Завдання 1. Витік пам’яті через сильні посилання
class Person {
    var name: String
    weak var friend: Person?    // використали weak щоб не було витокі пам'яті
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) deinit")
    }
}


var person1: Person? = Person(name: "Alice")
var person2: Person? = Person(name: "Bob")

// Створюємо цикл сильних посилань
person1?.friend = person2
person2?.friend = person1

// Розриваємо посилання
person1 = nil
person2 = nil  // Тут деініціалізатор не спрацює через цикл сильних посилань

// --------------------------------------------------------------- //
print("\n")

class Human {
    var name: String
    // weak var employer: Company? // сильне посилання на компанію ❌
    unowned let employer: Company
    
    init(name: String, employer: Company) {
        self.name = name
        self.employer = employer
        print("\(name) created!")
    }
    
    func introduce() { print("Hi, I am \(name).")}
    
    deinit {
        print("\(name) deinit")
    }
}

class Company {
    // У масиві елементи зберігаються як сильні посилання → тобто Company володіє Human
    var employees: [Human] = []
    
    // додає співробітника до масиву
    func addEmployee(name: String) {
        let employee = Human(name: name, employer: self)
        employees.append(employee)
        }
    
    // викликає метод introduce()  для кожного спіробітника в масиві
    func introduceEmplayees() {
        employees.forEach { employee in
            employee.introduce()
            
        }
    }
    
    deinit {
            print("Company deinit")
        }
}

var company: Company? = Company()
//var human1: Human? = Human(name: "John")
//var human2: Human? = Human(name: "Alice")
//
//company?.addEmployee(human1!)
//company?.addEmployee(human2!)

company?.addEmployee(name: "John")
company?.addEmployee(name: "Alice")
company?.introduceEmplayees()

company = nil
//human1 = nil
//human2 = nil

/*
Але якщо зробити так:
var company: Company? = Company()
var john: Human? = Human(name: "John", employer: company!)
company = nil
john?.employer // 💥 CRASH, бо company вже нема
*/
print("\nСтворення об'єктів:\n")

class Book {
    var title: String
    
    init(title: String) {
        self.title = title
        print("'\(title)' book created!")
    }
    
    deinit {
        print("'\(title)' book deinitialized!")
    }
}

class Author {
    var name: String
    
    init(name: String) {
        self.name = name
        print("\(name) Author created!")
    }
    
    deinit {
        print("\(name) Author deinitialized!")
    }
}


class Library {
    var name: String
    var books: [Book] = []
    
    init(name: String) {
        self.name = name
        print("\(name) Library created.")
    }
    
    deinit {
        print("\(name) Library deinitialized.")
    }
}

class Member {
    var name: String
    weak var library: Library?
    
    init(name: String) {
        self.name = name
        print("\(name) member created.")
    }
    
    deinit {
        print("\(name) member deinitialized.")
    }
}

var book1: Book? = Book(title: "The Da Vinci Cod")
var author1: Author? = Author(name: "Dan Brown")
var library1: Library? = Library(name: "Central Library")
var member1: Member?  = Member(name: "Max")

//  Встановлюємо взаємозалежні посилання

library1?.books.append(book1!) // - бібліотека утримує книгу(strong reference)
member1?.library = library1 // - член бібліотеки утримує бібліотеку (strong reference)


// Створення замикання, яке захоплює book1 і author1
let closure1 = { [weak book1, weak author1] in
    print("\(book1?.title ?? "") written by \(author1?.name ?? "")")
}


//  Створення замикання, яке захоплює library1 і member1
let closure2 = { [weak library1, weak member1] in
    print("\(member1?.name ?? "") is a member of \(library1?.name ?? "") library")
}

// Викликаємо
closure1()
closure2()

print("\nSetting objects to nil...\n")
book1 = nil
author1 = nil
library1 = nil
member1 = nil

// MARK:  ---- TASK - 1 (Strong vs Weak) ----
print("\n ---- TASK - 1 (Strong vs Weak) ----")
class Somebody {
    var name: String
    var car: Car?  // дописуєм weak щоб звільнити пам'ять
    
    init(name: String) {
        self.name = name
        print("👤 Somebody \(name) створений")
    }
    
    deinit {
        print("❌ Somebody \(name) звільнений з пам’яті")
    }
}

class Car {
    var brand: String
    var owner: Somebody?    //дописуєм weak щоб звільнити пам'ять
    
    init(brand: String) {
        self.brand = brand
        print("🚗 Car \(brand) створена")
    }
    
    deinit {
          print("❌ Car \(brand) звільнена з пам’яті")
      }
}

var somebody: Somebody? = Somebody(name: "Max")
var car: Car? = Car(brand: "Citroen")

somebody?.car = car     // Somebody → утрмує → Car
car?.owner = somebody   // Car → утрмує → Somebody

somebody = nil          // пробуємо звільнити з памʼяті обʼєкт somebody
car = nil                // пробуємо звільнити з памʼяті обʼєкт car


// MARK:  ---- TASK - 2 (Unowned vs Weak) ----
print("\n ---- TASK - 2 (Unowned vs Weak) ----")
class Customer {
    var name: String
    var creditCard: CreditCard? // Сильне посилання на картку
    
    init(name: String) {
        self.name = name
        print("Create customer with name: \(name)")
    }
    
    deinit {
        print("Customer \(name) deinit")
    }
}

class CreditCard {
    var number: String
    unowned var owner: Customer // `unowned`, бо картка не може існувати без власника
    
    init(number: String, owner: Customer) {
        self.number = number
        self.owner = owner
        print("Create creditcard: \(number)")
    }
    
    deinit {
            print("Card with number: \(number) deinit")
        }
}

var customer: Customer? = Customer(name: "Alex")
customer?.creditCard = CreditCard(number: "4444 7800 9823 9943", owner: customer!)

customer = nil

/*
🔹 Як працює
Customer strong тримає картку.
CreditCard має unowned посилання на Customer (не збільшує лічильник).
Тепер, якщо зробити:
customer = nil
ARC звільнить і Customer, і CreditCard ✅.

⚠️ А тепер головне питання
Що буде, якщо Customer зникне, а CreditCard залишиться?
Відповідь:
unowned не стає nil, на відміну від weak.
Тобто owner все ще буде посилатись на ту область пам’яті, де вже немає об’єкта.
Якщо ти спробуєш звернутись до card.owner, буде crash (runtime error).
Тому unowned варто використовувати тільки тоді, коли ти на 100% впевнений, що об’єкт житиме стільки ж, скільки й власник.
 
 */


// MARK:  ---- TASK - 3 (Closures & retain cycle) ----
print("\n ---- TASK - 3 (Closures & retain cycle) ----")
class Downloader {
    var completion: (() -> Void)?
    
    func download(completion: @escaping() -> Void) {
        self.completion = completion
    }
}

class ViewController {
    var downloader = Downloader()
    
    init() {
        print("ViewController init")
    }
    
    func startDownload() {
        downloader.download { [weak self] in    // + [weak self] in guard let self else { return }
            guard let self else { return }      // для уникнення витоку пам'яті
               // ⚠️ Тут strong reference на self
               print("Download finished for \(self)")
           }
       }
    
    deinit {
          print("ViewController deinit")
      }
}

// Тест
var vc: ViewController? = ViewController()
vc?.startDownload()
vc = nil

