import UIKit

// Loops
let count = 1...10

for number in count {
    print("Number is \(number)")
}

let albums = ["Red", "1989", "Reputation"]

for album in albums {
    print("\(album) is on Apple Music")
}

print("Players gonna ")

for _ in 1...5 {
    print("play")
}
print("\n")


// While loops (дайте умову і код циклу буде ходити навколо і навколо, поки умова не вийде з ладу.)
var number = 1

while number <= 20 {
    print(number)
    number += 1
}

print("Ready or not, here I come!")

var pianoLesson = 1
while pianoLesson < 5 {
    print("This lesson \(pianoLesson)")
    pianoLesson += 1
}
print("\n")


// Repeat - while loops
var point = 1

repeat {
    print("Point \(point)")
    point += 1
} while point <= 20

print("Ready or not, here I come!")

// Надрукує повідомлення тому що умова перевіряється в кінці
repeat {
    print("This is false")  // виводить повідомлення
} while false

// А тут так не спрацює
while false {
    print("This is false")  // не виводить повідомлення
}
print("\n")


// Keyword - break -
var countDown = 10

while countDown >= 0 {
    print(countDown)
    
    if countDown == 4 {
            print("I'm bored. Let's go now!")
            break
        }
    
    countDown -= 1
}
print("\n")


// Multiply exiting loops (вихід з вкладених(nested) циклів)
let options = ["up", "down", "left", "right"]
let secretCombination = ["up", "up", "right"]

// Намагаємося з'ясувати правильне поєднання рухів, щоб розблокувати сейф.
for option1 in options {
    for option2 in options {
        for option3 in options {
            print("In loop")
            let attempt = [option1, option2, option3]

            if attempt == secretCombination {
                print("The combination is \(attempt)!")
            }
        }
    }
}

print("-----------------------------")

outerLoop: for option1 in options {
    for option2 in options {
        for option3 in options {
            print("In loop")
            let attempt = [option1, option2, option3]

            if attempt == secretCombination {
                print("The combination is \(attempt)!")
                break outerLoop // Вихід з усіх петель - як тільки буде знайдено комбінацію.
            }
        }
    }
}
print("\n")


// Keyword - continue -
for i in 1...10 {
    if i % 2 == 1 {
        continue    // пропускає не парне число
    }

    print(i)
}
print("\n")


// Infinite loops (нескінченні цикли)
var counter = 0

while true {
    print("_")
    counter += 1
    
    // перевірка на вихід з циклу інакше він ніколи не закінчиться
    if counter == 273 {
        break
    }
}
