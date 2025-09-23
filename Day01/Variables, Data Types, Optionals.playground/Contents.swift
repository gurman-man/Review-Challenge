import UIKit
// reference type - клас
// value     type - структури, enums, кортежі

// Type Anotation
var name: String
name = "Max"
name = "Devid"

// create constant
// let створює immutable binding(посилання незмінне), але якщо це reference type(клас) то властивості цього об'єкта  - можна змінити.
let integer = 5

class User {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}
// приклад зміни об'єкта u
let u = User(name: "Max")
u.name = "Yarina"
print(u.name)


print(name)
print(integer)

// String Interpolation
var age = 19
"Your name is \(name),your age is \(age)."

var z = 0.0,
    y = 0.0,
    a = 0.0

print("Value z: \(z)\nValue y: \(y)\nValue a: \(a)")

// Двокрапка для написання кількох окремих операторів
let cat = "cat"; print(cat)


// MARK: Swift Types

// float
var latitide: Float
latitide = 36.5674783

// double
var longitude: Double
longitude = 56.56546353653

// string
let login: String
login = "mail.com"

// int
let myAge: Int
myAge = 20

// bool
var isLogin: Bool
isLogin = false

// UInt -  це Unsigned Integer - тільки додатні значення, 0 і більше.
let minValue = UInt8.min
let maxValue = UInt8.max
