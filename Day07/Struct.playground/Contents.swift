import UIKit

// Creating struct
struct Sport {
    var name: String
}

var tennis = Sport(name: "Tennis")
print(tennis.name)

tennis.name = "Lawn tennis" // можемо змінювати
print("-----------------------------------------")


// Computed properties
struct Game {
    var name: String
    var isCyberSport: Bool
    
    /*
        Обчислювальна властивість завжди:
                - оголошується через  var
                - повертає (return) значення
    */
    
    var cybercStatus: String {
        if isCyberSport{
            return "\(name) is an Cyber Sport"
        } else {
            return "\(name) is not an Cyber Sport"
        }
    }
}

let counterSrike = Game(name: "Counter-Srike", isCyberSport: false)
print(counterSrike.isCyberSport)
print("-----------------------------------------")


// Property observers (спостерігачі за властивостями)
struct Progress {
    var task: String
    var amount: Int {
        didSet {
            print("\(task) is now \(amount)% complete")
        }
    }
}

var progress = Progress(task: "Loading data", amount: 0)
progress.amount = 30
progress.amount = 60
progress.amount = 100
print("-----------------------------------------")


// Methods
struct City {
    var population: Int
    
    func collectTaxes() -> Int {
        return population * 1000
    }
    
}

let london = City(population: 9_000_000)
print(london.collectTaxes())
print("-----------------------------------------")

// Mutating Methods
struct Person {
    var name: String
    
    mutating func makeAnonymous() {
        name = "Anonymous"
    }
}

var person = Person(name: "Ed")
print(person.makeAnonymous())
print("-----------------------------------------")


// Properties and methods of strings
let string = "Do or do not, there is no try."

print(string.count)
print(string.hasPrefix("Do"))
print(string.uppercased())
print(string.sorted())
print("-----------------------------------------")

// Properties and methods of arrays
var toys = ["Woody"]
print(toys.count)

toys.append("Buzz")
toys.firstIndex(of: "Buzz")

print(toys.sorted())
print(toys.remove(at: 0))
