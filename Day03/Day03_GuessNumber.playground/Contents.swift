import UIKit

let secretNumber = Int.random(in: 1...10)

let userGuess: Int = 6

switch userGuess {
case secretNumber:
    print("You guessed!")
case ..<secretNumber:
    print("Too few.")
case (secretNumber+1)...:
    print("Too many.")
default:
    print("")
}

print("\n")


// Приклади закритого діапазону 1...10
for i in 1...10 {
    print(i)
}

print("\n")

// Приклади нdпівqвідкритого діапазону 0...7
for i in 0..<7 {
    print(i)
}
