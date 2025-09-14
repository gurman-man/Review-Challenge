import UIKit
// Functions
func printHelp() {
    let message = """
Welcome to my App!

Run this app inside a directory of images and
My App resize  them all into thumbnails
"""
    print(message)
}

printHelp()
print("------------------------------------------")


// creating functions with parameters : name, year

func favouriteAlbum(name: String, year: Int) {
    print("\(name) was released in \(year)")
}

favouriteAlbum(name: "Fearless", year: 2008)
print("------------------------------------------")


// creating functions with returning values
func square(number: Int) -> Int {
    return number * number
}

let result = square(number: 8)
print(result)
print("------------------------------------------")


// виклик функції через зовнішній параметр string
func countLettersInString(myString str: String) {
    print("The String : \(str) has count \(str.count) letters.")
}
countLettersInString(myString: "Hello;")
print("------------------------------------------")


// виклик функції через зовнішній параметр in
func countLetters(in string: String) {
    print("The string: \(string) has \(string.count) letters.")
    // внутрішній параметр (string) - звертаємось у середині функції
}

countLetters(in: "Hello;")  // зовнішній параметр (in) - викликається під час виклику функції
print("------------------------------------------")


// Пропус мітки аргументу у функції
func greet(_ person: String) {
    print("Hello, \(person)!")
}

greet("Taylor")
print("------------------------------------------")


// Параметри за замовчуванням у функції
func findDirections(from: String, to: String, route: String = "fastest", avoidHighways: Bool = false) {
    // code here
}

findDirections(from: "London", to: "Glasgow")
findDirections(from: "London", to: "Glasgow", route: "scenic")
findDirections(from: "London", to: "Glasgow", route: "scenic", avoidHighways: true)
print("------------------------------------------")


// Variadic functions (варіаційні)
func printNumbers(numbers: Int...) {
    for number in numbers {
        print(number)
    }
}

printNumbers(numbers: 1, 2, 3)
print("------------------------------------------")


// Throwing functions (кидаючі)
enum PasswordError: Error {
    case obvious
}

func checkPassword(_ password: String) throws -> Bool {
    if password == "password" {
        throw PasswordError.obvious
    }
    
    return true
}

do {
    try checkPassword("password")
    print("That password is good!")
} catch {
    print("You can't use that password.")
}
print("------------------------------------------")


// Параметр inout(у функції)
func doubleInPlace(number: inout Int) {
    number *= 2
}

// щоб передати параметер inout - використовуй &
var myNum = 10
doubleInPlace(number: &myNum)


