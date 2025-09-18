import UIKit

// Крок 1. Протокол (контракт)
protocol Animal {
    var name: String { get }
    func makeSound()
}

// Крок 2. Протокол з успадкуванням
protocol FastAnimal: Animal {
    func runFast()
    static var maxSpeed: Int { get }    // додатково для змагання
}

// Крок 3. Структури / класи, що відповідають протоколам
struct Dog: Animal {
    var name: String
    
    func makeSound() {
        print("hauu - hauu")
    }
    
}

// Cheetah - гепард
class Cheetah: FastAnimal {
    var name: String
    nonisolated(unsafe) static var maxSpeed = 120
    
    init(name: String) {
        self.name = name
    }
    
    func makeSound() {
        print("Grrr")
    }
    
    func runFast() {
        print("\(name) runs at \(Cheetah.maxSpeed) km/h")
    }
}

struct Bird: Animal {
    var name: String
    
    func makeSound() {
        print("Chirp  chirp")
    }
}

// Крок 4. Extension (розширення)
// Bird використовує дефолтну поведінку introduce()

extension Animal {
    func introduce() {
        print("Hello, I am an animal \(name)")
    }
}

// Крок 5. Protocol extension (дефолтна реалізація)

extension Animal {
    func makeSound() {
        print("I an an animal and I have a sound.")
    }
}

// Крок 6. Поліморфізм та масив тварин
let animals: [Animal] = [
    Dog(name: "Rex"),
    Cheetah(name: "Flash"),
    Bird(name: "Tweety")
]

for animal in animals {
    animal.introduce()      // метод з extension
    animal.makeSound()      // власний звук або дефолтний
    print("\n")
    
    if let fastAnimal = animal as? FastAnimal {
        fastAnimal.runFast()
        print("\n")
    }
}


