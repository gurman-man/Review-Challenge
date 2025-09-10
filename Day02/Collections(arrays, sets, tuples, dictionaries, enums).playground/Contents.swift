import UIKit

// MARK: Array
let john = "John Lennon"
let paul = "Paul McCartney"
let george = "George Harrison"
let ringo = "Ringo Starr"

let beatles = [john, paul, george, ringo]
beatles[2]

var evenNumbers = [2, 4, 6, 8]
var songs = ["Shake it OFF", "Bulletproof", "Just Dance"]

songs[0]
songs[1]
songs[2]

type(of: songs)

// array with diferent data types
var Array: [Any] = ["Max have ", 8, "years old"]

// create empty array with further use (подальшим використанням)
var devices = [String]()


// MARK: Set
let colors = Set (["red", "green", "blue"])
let colors2 =  Set(["red", "green", "blue", "red", "blue"]) // дублікати ігоруються


// MARK: Tuples
var name = (first: "Taylor", last: "Swift")
name.0
name.last
var name2 = (first: "Justin", age: 25)  // можуть бути значення різного типу


// MARK: Dictionaries
let heights = [
    "Taylor Swift": 1.78,
    "Ed Sheeran": 1.73
]
heights["Taylor Swift"]

let favoriteIceCream = [
    "Paul": "Chocolate",
    "Sophie": "Vanilla"
]
favoriteIceCream["Paul"]
favoriteIceCream["Charlotte"]   // задаєму словнику значення за замовчуванням


// MARK: Remember:
// arrays  - зберігають порядок і можуть мати дублікати,
// set     - не впорядковані і не можуть мати дублікатів,
// tuples  - мають фіксовану кількість значень фіксованих типів всередині них.

// Створення пустих колекцій (масиви, множини та словники)
var teams = [String: String]()          // порожній словник
teams["Paul"] = "Red"                   // додаємо запис пізніше
var scores = Dictionary<String, Int>()  // інша форма запису порожнього словника

var results = [Int]()                   // порожній масив

var words = Set<String>()               // порожня множина


// MARK ENUMS:
enum Direction {
    case north(destination: String)
    case south(destination: String)
    case east(destination: String)
    case west(destination: String)
}

// Enum associated values (пов'язані значення)
let adventure = Direction.east(destination: "JAPAN, CHINA, INDIA" )

// Enum raw values (необроблені значення)
enum Planet: Int {
    case mercury = 1
    case venus
    case earth
    case mars
}

let earth = Planet(rawValue: 2)
