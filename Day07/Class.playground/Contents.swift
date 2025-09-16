import UIKit

// Creating class
class Developer {
    
    var name: String?
    var jobTitle: String?
    var yearsExp: Int?
    
    init(name: String, jobTitle: String, yearsExp: Int) {
        self.name       = name      // self.name - властивість класу
        self.jobTitle   = jobTitle
        self.yearsExp   = yearsExp
    }
    
    func speakName() {
        print(name!)
    }
}
print("---------------------------------------------")


// inheritance
class iOSDeveloper: Developer {
    var favouriteFramework: String?
    
    func speakFavouriteFramework() {
        if let favouriteFramework = favouriteFramework {
            print(favouriteFramework)
        } else {
            print("I don't have favourite framework")
        }
    }
        override func speakName() {
            print("\(name!) - \(jobTitle!)")
        }
    }

// Creating instance (екземпляра)
// аргументи записуються ті що в ініціалізаторі
let Max = iOSDeveloper(name: "Max", jobTitle: "iOS Engineer", yearsExp: 2)

Max.favouriteFramework = "Swift UI"
Max.speakFavouriteFramework()
Max.speakName()
print("---------------------------------------------")


// Overriding methods
class Animal {
    func makeSound() {
        print("The animal makes a sound")
    }
}

class Dog: Animal {
    override func makeSound() {
        print("Woof woof")
    }
}

let dog = Dog()
dog.makeSound()
print("---------------------------------------------")


// Final classes
final class Cat {
    var name: String
    var breed: String

    init(name: String, breed: String) {
        self.name = name
        self.breed = breed
    }
}
print("---------------------------------------------")

// Copying objects
// Classes - при привоєнні або передачі класу стврюється нвое посилання на той самий об'єкт. І екземпляри == одне одному.
// Structs - при привоєнні або передачі структури створстврюється нова копія. І екземпляри != одне одному.
class Author {
    var name = "Anonymous"
}

var dickens = Author()
dickens.name = "Charles Dickens"
var austen = dickens
austen.name = "Jane Austen"
print(dickens.name)
print(austen.name)
print("---------------------------------------------")

// Deinitializers
class Person {
    var name = "John Doe"
    
    init() {
        print("\(name) is alive!")
    }
    
    func printGreeting() {
        print("Hello, I'm \(name)")
    }
    
    deinit {
        print("\(name) is no more!")
    }
}

for _ in 1...3 {
    let person = Person()
    person.printGreeting()
}
print("---------------------------------------------")


// Mutability
// Класи дозволяють нам змінювати властивість якщо вона була оголошена у класі через - var
class Singer {
    var name = "Taylor Swift"
}

let taylor = Singer()
taylor.name = "Ed Sheeran"
print(taylor.name)
