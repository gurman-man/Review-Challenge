import UIKit

struct Friend {
    let name: String
    let age: Int
}
// Практика – сортування масиву
let friends = [
    Friend(name: "Ehor", age: 21),
    Friend(name: "Yaryna", age: 18),
    Friend(name: "Max", age: 20)
]

// Функція для порівняння
func compareByAge(_ a: Friend, _ b: Friend) -> Bool {
    return a.age < b.age
}

let sorted1 = friends.sorted(by: compareByAge)

// 1. За віком ↑
let sorted1String = sorted1
    .map { "\($0.name) – \($0.age)" }        // робимо масив рядків
    .joined(separator: ", ")                 // склеюємо в один рядок
print("Sorted by age ascending: \(sorted1String)")


// Замикання для порівняння
let compareByName = { (f1: Friend, f2: Friend) -> Bool in
    return f1.name < f2.name    // сортування за алфавітом
}

let sorted2 = friends.sorted(by: compareByName)

// 2. За ім’ям (алфавіт)
let sorted2String = sorted2
    .map { $0.name }
    .joined(separator: ", ")
print("Sorted by name: \(sorted2String)")


// Trailing closure
let sorted3 = friends.sorted { (f1, f2) -> Bool in
    return f1.age > f2.age
}

// 3. За віком ↓
let sorted3String = sorted3
    .map { "\($0.name) – \($0.age)" }
    .joined(separator: ", ")
print("Sorted by age descending: \(sorted3String)")


// 4. Короткі параметри
let sorted4 = friends.sorted { $0.name > $1.name }

let sorted4String = sorted4
    .map { "\($0.name)" }
    .joined(separator: ", ")
print("Sorted by name descending: \(sorted4String)")


// Практика – map
print("----------------------------------------------------------")
var randomNumbers: [Int] = []

for number in 0...10 { // 10 випадкових чисел
    randomNumbers.append(Int.random(in: 1...100))
}
print("Original: \(randomNumbers)")

let doubled1 = randomNumbers.map { (number: Int) -> Int in
    number * 2
}
print("Doubled1: \(doubled1)")


let humanName: (String) -> String = { name in
    return "Hello, \(name)!"
}

print(humanName("Olha"))
print(humanName("Max"))
print(humanName("Andrew"))
