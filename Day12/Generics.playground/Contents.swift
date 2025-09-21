import UIKit

// MARK: GENERICS (загальні)

// generic function
func driveHome<T: Drivable>(vehicle: T) {
    print("I am back to home on my \(vehicle)")
}

// generic protocol
protocol Drivable {
    var motor: Motor { get }
    var wheels: Int { get }
}

// generic struct
struct Motor {
    var engine: String
}

struct Porsche911GT3: Drivable {
    var motor: Motor
    var wheels: Int
}

struct Motorcycle: Drivable {
    var motor: Motor
    var wheels: Int
}

let my911 = Porsche911GT3(motor: Motor(engine: "4.0 litre 6-cylinder"), wheels: 4)
let myMotorcycle = Motorcycle(motor: Motor(engine: ""), wheels: 2)

driveHome(vehicle: my911)
driveHome(vehicle: myMotorcycle)
print("-------------------------------")

// Practice Sean Alean:
func determineHigherValue<T: Comparable>(valueOne: T, valueTwo: T) {
    let higherValue = valueOne > valueTwo ? valueOne : valueTwo
    print("\(higherValue) is the higher value")
}

determineHigherValue(valueOne: 1, valueTwo: 10)
determineHigherValue(valueOne: "Sean", valueTwo: "Max")
determineHigherValue(valueOne: Date.now, valueTwo: Date.distantFuture)
print("-------------------------------")

// Practice:
// Generic function
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let value = a
    a = b
    b = value
}

// Перевірка на Int
var int1 = 10
var int2 = 5
print("Before:      int1 = \(int1),    int2 = \(int2)")
swapTwoValues(&int1, &int2)
print("After:       int1 = \(int1),     int2 = \(int2)\n")

// Перевірка на String
var str1 = "Hello"
var str2 = "World"

print("Before:      str1 = \(str1),    str2 = \(str2)")
swapTwoValues(&str1, &str2)
print("After:       str1 = \(str1),    str2 = \(str2)")
print("-------------------------------")


// Generic struct - STACK
struct Stack<T> {
    var items: [T] = []
    
    mutating func push(_ item: T) {
        items.append(item)
        print("Push item: \(item)")
    }
    
    mutating func pop() -> T? {
        return  items.popLast()
    }
    
    // повертає верхній елемент без видалення
    mutating func peek() -> T? {
        return items.last
    }
}


// Перевірка
var intStack = Stack<Int>()
intStack.push(10)
intStack.push(20)
intStack.push(30)

print("Stack Int: \(intStack.items)")
print("peek:", intStack.peek() ?? "emty stack")
print("pop:", intStack.pop() ?? "emty stack")
print("Final Stack Int: \(intStack.items)")
print("-------------------------------")


// Procol with associated type
protocol Container {
    associatedtype Item     // associated - узагальнений тип
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}


// Розширення Stack<T>
extension Stack: Container {
    
    mutating func append(_ item: T) {
        self.push(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> T {
        return items[i]
    }
}

// Перевірка
var stringStack = Stack<String>()
stringStack.append("Hello")
stringStack.append("World")
print("Count: \(stringStack.count)")
print("Eelement[1]: \(stringStack[1])")
print("-------------------------------")


// Узагальнена функція пошуку
func findIndex<T: Equatable>(of value: T, in array: [T]) -> Int? {
    for(index,item) in array.enumerated() {
        if item == value {
            return index
        }
    }
    return nil
}

let intIndex = findIndex(of: 1, in: [19, 39, 40, 50, 83, 23])
print("Found int index: \(intIndex ?? -1)")
let stringIndex = findIndex(of: "Malcon", in: ["Mike", "Andrew", "Jack", "Malcon"])
print("Found string index: \(stringIndex ?? -1)")
print("-------------------------------")
