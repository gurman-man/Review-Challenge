import UIKit

// Protocols - спосіб опису вимог, які повенен реалізувати клас, структура або перерахування
protocol Identifiable{
    var id: String { get set }  // властивість var чи let повинна мати завжди get -  щоб зчитувати значення, або ж get і set - щоб читатися і змінюватися.
}

// створюємо структуру, яка відповідає протоколу
struct User: Identifiable {
    var id: String
}

// зрештою, пишемо функцію яка приймає Identifiable object
func displayID(thing: Identifiable) {
    print("My ID is \(thing.id)")
}
print("----------------------------")


// Protocol inheritance ( можуть успадковуватись від інших протоколів)
protocol Payable {
    func calculateWages() -> Int
}

protocol NeedsTraining {
    func study()
}

protocol HasVacation {
    func takeVacation(days: Int)
}

// Тепер ми можемо створити єдиний протокол Employee, який об'єднує їх в одному протоколі
protocol Employee: Payable, NeedsTraining, HasVacation { }


// Extensions - додають нові методи, властивості (лише computed) до класів, структур, перерахувань, протоколів
// тобто ми пишемо extensions спеціально для класів, структур, перерахувань, протоколів.
// У той же час протоколи протоколи також пишемо для класів, структур, перерахувань, але без реалізації методів лише оголошення
extension Int {
    func squared() -> Int {
        return self * self
    }
}

let number = 8
print(number.squared())
print("----------------------------")


// Protocol extensions
let pythons = ["Eric", "Graham", "John", "Michael", "Terry", "Terry"]
let beatles = Set(["John", "Paul", "George", "Ringo"])

extension Collection {
    func summarize() {
        print("There are \(count) of us:")
        
        for name in self {
            print(name, terminator: "; ")
        }
    }
}

pythons.summarize()
print("\n")
beatles.summarize()
print("\n----------------------------")


// protocol-oriented programming
extension Identifiable {
    func identify() {
        print("My ID is \(id).")
    }
}

let twostraws = User(id: "twostraws")
twostraws.identify()

// Summarize:
/*
    1. Протоколи описують, які методи та властивості повинен мати відповідний тип, але не передбачають реалізації цих методів.
 
    2. Ви можете створювати протоколи поверх інших протоколів, подібних до класів.
 
    3. Розширення дозволяють додавати методи та обчислені властивості до певних типів, таких як Int.
 
    4. Розширення протоколу дозволяють додавати методи та обчислені властивості до протоколів.
*/
