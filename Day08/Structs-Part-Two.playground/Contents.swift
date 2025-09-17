import UIKit

// Initializers (ініціалізатори)
struct User {
    var username: String

    // не вживамо ключове слово - func при створенні init
    init() {
        username = "Anonymous"
        print("Creating a new user!")
    }
}

var user = User()
user.username = "twostraws"
print("----------------------------------")


// keyword - Self
struct Boy {
    var name: String

    init(name: String) {                // name - параметер переданий до ініціалізатра
        print("\(name) was born!")
        self.name = name                // self.name - посилається на властивість структури
    }
}
print("----------------------------------")


// Lazy Properties
struct FamilyTree {
    init() {
        print("Creating family tree!")
    }
}

// Ми можемо використовувати структуру FamilyTree як властивість всередині структури Person
// Ліниві властивості Swift дозволяють нам відкласти створення властивості, тобто:
// якщо ви хочете побачити повідомлення "Creating family tree!" потітрбно викликати ЇЇ  - ed.familyTree

struct Person {
    var name: String
    lazy var familyTree = FamilyTree()
    
    init(name: String, familyTree: FamilyTree = FamilyTree()) {
        self.name = name
        self.familyTree = familyTree
    }
}

var ed = Person(name: "Ed")
print(ed.name)
ed.familyTree
print("----------------------------------")


// Static properties and methods
// - static функції / властивості можна викликати без необхідності створювати екземпляр класу / структури
struct Math {
    static func square(number: Int) -> Int {
        return number * number
    }
}

let result = Math.square(number: 4)
print(result)   // 16
print("----------------------------------")


// Access control
/*
 - private:         Обмежує доступ до елемента в межах класу
 - public:          Дозволяє доступ з будь-якого місця
 - file - private:  Обмежує доступ до елемента в межах файлу
 - iternal:         Обмежує доступ до елемента в межах модуля
 
*/
struct Customer {
     private var id: String

    init(id: String) {
        self.id = id
    }
    
    func identify() -> String {
            return "My social security number is \(id)"
        }
}

let jack = Customer(id: "12345")
// print(jack.id) - немає доступу (( бо private
