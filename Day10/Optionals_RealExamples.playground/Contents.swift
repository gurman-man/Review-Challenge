import UIKit

struct User {
    let name: String?
    let age: Int?
}

let user = User(name: "Max", age: 54)


// IF LET
if let age = user.age {
    //print("User's age is \(age)")
} else {
    //print("User did not enter an age")
}


// GUARD LET  (швидкий вихід з функцій)
func check(age: Int?) {
    guard let age = age else {
        print("Age is nil")
        return
    }
    
    if age > 50 {
        print("You are old.")
    }
}

check(age: user.age)


// NIL COALESCING
//let age = user.age ?? 0
let name = user.name ?? "Not given"
//print(age)


// FORCE UNWRAP
//let age = user.age!
//print(age)


// PTIONAL CHAINING
var optionalUser: User?
let newName = optionalUser?.name ?? "Not Given"

