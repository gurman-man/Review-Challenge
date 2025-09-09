import UIKit

// MARK: Optionals
var packet: String?
var air: Int? = nil
var userLogin: String?

userLogin = "admin"

var ages: [Int] = [21, 45, 18, 71, 44, 23, 17]
ages.sort ()


// if let
if let oldestAge = ages.last {
    print("The oldest age is \(oldestAge)")
} else {
    print("There is no oldest age. You must have no students.")
}


// nil coalsescing
//let oldestAge = ages.last ?? 0


// guard statement
@MainActor func getOldestAge() {
    guard let oldestAge = ages.last else {
        return
    }
    
    print("\(oldestAge) is the oldest age.")
}

getOldestAge()


// force unwrap
let oldestAge = ages.last!

