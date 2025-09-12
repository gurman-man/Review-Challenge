import UIKit

// Таблиця множення
let range = 1...5

for i in range {
    for k in range {
        print("\(i) x \(k) = \(i * k)")
    }
    print("")
}

print("\nNext task")


// Фільтрація парних чисел
let numbers = Array(1...20)

for number in numbers {
    if number.isMultiple(of: 2) {
        print("Number \(number) is even")
    }
}

// Фільрація непарних чисел
for points in numbers {
    if points % 2 == 0 {
        continue
    }
    print(points, terminator: " ")
}

print("\n\nNext task")


// Приклад while / repeat-while
var counter = 1

while counter <= 5 { print(counter); counter += 1 }

print("\n\nNext task")


// Приклад repeat-while
var value = 1
repeat {
    print(value)
    value += 1
} while value <= 5

print("\n\nNext task")


// Приклад break / continue / labeled loops
let shelves = ["Shelf 1", "Shelf 2", "Shelf 3"]
let items = [
    ["Banana", "Pineapple"],
    ["Orange", "Apple"],
    ["Plum", "Pear"], // слива, груша
]

outerLoop: for shelf in shelves {  // зовнішніф цикл з міткою
    for item in items[shelves.firstIndex(of: shelf)!] {
        if item == "Apple" {
            print("Found apple on \(shelf)")
            break outerLoop         // вихід з ОБОХ циклів одразу
        }
    }
    print("Ended checking \(shelf)")
}
print("Searching - ended!")
