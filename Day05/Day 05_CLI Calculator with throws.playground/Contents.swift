import UIKit

// MARK: Створення базових функцій для кожної операції(+, -, *, /)

func add(_ a: Double, _ b: Double) -> Double {
    return a + b
}

func subtract(_ a: Double, _ b: Double) -> Double {
    return a - b
}

func multiply(_ a: Double, _ b: Double) -> Double {
    return a * b
}

// Опис власних помилок для throw функції
enum CalculatorError: Error {
    case divisionByZero
    case invalidOperator
}

func divide(_ a: Double, _ b: Double) throws -> Double {
    if b == 0 {
        throw CalculatorError.divisionByZero
    }
    return a / b
}


// MARK: - Тестові дані
let first: Double = 10
let second: Double = 5
let op: String = "/"


// MARK: - Виклик функцій через switch
do {
    let result: Double
    switch op {
    case "+":
        result = add(first, second)
    case "-":
        result = subtract(first, second)
    case "*":
        result = multiply(first, second)
    case "/":
        result = try divide(first, second)
    default:
        fatalError("Unlnown operator!")
    }
    print("Result: \(result)")
} catch CalculatorError.divisionByZero {
    print("Error: division by zero!")
} catch {
    print("Unknown error: \(error)")
}


//  Label - параметри(іменовані параметри)
func greet(name: String, age: Int) {
    print("Hello, \(name)! You are \(age) years old.")
}

greet(name: "Max", age: 20)


// Default параметер
func power(base: Double, exponent: Double = 2) -> Double {
    return pow(base, exponent)
}

print(power(base: 5))


// Variadic function
func sum(_ numbers: Double...) -> Double {
    var total = 0.0
    for number in numbers {
        total += number
    }
    return total
}

print(sum(10.0, 20.0, 30.0))



// Параметр inout(у функції)
func change(_ message: inout String) {
    message = "!"
    print("Message: \(message)")
}

var myMessage = "Hello, world!"
change(&myMessage)
print("After function: \(myMessage)")

/// 📝 ПОЯСНЕННЯ:
/*
 - inout робить так, що всередині change ти працюєш не з копією, а з оригінальною змінною myMassege.
 - Під час виклику треба писати &myMassege — це сигнал компілятору: «ця функція може змінювати значення».
 - Усередині ти переприсвоюєш massage = "!", тому оригінальна змінна myMassege теж стає "!".
 - На виході print("After function: \(myMassege)") покаже "!".
 
 - Якби ти забрав inout і &, то зміна відбулася б лише всередині функції, а зовні залишилася б "Hello,
 world!".
*/
