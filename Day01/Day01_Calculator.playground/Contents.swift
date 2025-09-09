import UIKit

// if let використовуємо лише коли у нас є опціональне значення(щоб розпакувати його) в іншому випадку просто виводимо  - print("The forecast is \(forecast).").
var weatherForecast: String? = "sunny"
if let forecast = weatherForecast {
    print("The forecast is \(forecast).")
} else {
    print("No forecst available.")
}

// MARK: CLI Calculator
let numberOne = 10
let numberTwo = 5
let operation: Character = "0"

var result: Int?

if operation == "/" {
    result = numberOne + numberTwo
} else if operation == "-" {
    result = numberOne - numberTwo
} else if operation == "*" {
    result = numberOne * numberTwo
} else if operation == "/" {
    if numberTwo != 0 {
        result = numberOne / numberTwo
    } else {
        print("Error: division by zero!")
        result = nil
    }
} else {
    print("Unknown operation")
    result = nil
}

// Вивід результату з nil-coalescing
print("Result: \(result ?? 0)")


// MARK: Optional + Nil-Coalescing
var optionalResult: Int? = 5
print("Optional example: \(optionalResult ?? 0)")
