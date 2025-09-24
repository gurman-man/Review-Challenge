import UIKit

// Arithmetic Operators
let firstScore = 12
let secondScore = 4

let total = firstScore + secondScore        // Addition
let difference = firstScore - secondScore   // Subtracttion

let product = firstScore * secondScore      // Multiplication
let divided = firstScore / secondScore      // Division

let remainder = 13 % secondScore            // Remainder operator (оператор залишку)


// Operator overloading (Оператори перезавантаження)
let fakers = "Fakers gonna "
let action = fakers + "fake"

let firstHalf = ["John", "Paul"]
let secondHalf = ["George", "Ringo"]
let beatles = firstHalf + secondHalf


// Assignment operators (Оператори присвоєння)
var score = 95
score -= 5

var quote = "The rain in Spain falls mainly on the "
quote += "Spaniards"


// Comparison operators (Оператори порівняння)
firstScore == secondScore
firstScore != secondScore

firstScore < secondScore
firstScore >= secondScore

"Max" <= "Swift"


// Conditions (Умови)
let firstCard = 1
let secondCard = 1

if firstCard + secondCard == 2 {
    print("Aces - lucky!")  // Тузи - щасливчики!
} else if firstCard + secondCard == 21 {
    print("Blackjack!")
} else {
    print("Regular cards")
}


// Combining conditions (Логічні оператори)
let age1 = 12
let age2 = 21

if age1 > 18 && age2 > 18 {
    print("Both are over 18")
}

if age1 > 18 || age2 > 18 {
    print("At least one is over 18")
}


// The ternary operator
let cardOne = 11
let cardTwo = 10
print(cardOne == cardTwo ? "Cards are the same" : "Card are different")


// Swith statements
let weather = "sunny"

switch weather {
case "rain" :
    print("Bring an umbrella")
case "snow" :
    print("Wrap up warm")
case "sunny" :
    print("Wear sunscreen")
    fallthrough                 // виводить default значення разом із основним
default:
    print("Enjoy your day!")
}


// Range Operators (Оператори діапазону)
let scoreStudents = 85

switch scoreStudents {
case 0..<50:
    print("You failed badly.")
case 0..<85:
    print("You did OK.")
default:
    print("You did great!")
}

let points = ...5
print(points)
