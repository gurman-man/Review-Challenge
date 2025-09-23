import UIKit

struct IndieApp {
    let name: String
    let monthlyPrice: Double
    let users: Int
}

let appPortfolio = [
    IndieApp(name: "Creator Veiw", monthlyPrice: 11.99, users: 4356),
    IndieApp(name: "FitHero", monthlyPrice: 0.00, users: 1756),
    IndieApp(name: "Buckets", monthlyPrice: 3.99, users: 7598),
    IndieApp(name: "Connect Four", monthlyPrice: 1.99, users: 34081)]

// MARK: Filter
let highUsers = appPortfolio.filter { $0.users > 5000 }

// Longest version:
//
//var highUsers: [IndieApp] = []
//
//for app in appPortfolio {
//    if app.users > 5000 {
//        highUsers.append(app)
//    }
//}

print(highUsers,"ends - Filter\n")


// MARK: MAP
let appNames = appPortfolio.map { $0.name }.sorted()
print(appNames)

let increasedPrices = appPortfolio.map { $0.monthlyPrice * 1.5 }
print(increasedPrices,"ends - Map\n")


// MARK: Reduce
let numbers = [3, 5, 9, 12, 18]
let sum = numbers.reduce(100, -)
print(sum)

let totalUsers = appPortfolio.reduce(0, { $0 + $1.users })
print(totalUsers, "ends - Reduce\n")


// MARK: Chaining
let recurringRevenue = appPortfolio.map { $0.monthlyPrice * Double($0.users) }.reduce(0, +)
print(recurringRevenue,"ends - Chaining\n")


// MARK: Compact Map
let nilNumbers: [Int?] = [1, nil, 17, nil, 3, 7, nil, 99]
let nonNilNumbers = nilNumbers.compactMap { $0 }
print(nonNilNumbers, "ends - Compact Map\n")


// MARK: Flat Map
let arrayOfArrays: [[Int]] = [[1,2,3],
                               [4,5,6],
                               [7,8,9]]

let singleArray = arrayOfArrays.flatMap { $0 }
print(singleArray, "ends - Flat Map\n-------------------------------------------")


// MARK: PRACTICE LEVEL - BASIC

// Map - за допомогою маp зроби масив довжини слів
let languages = ["Swift", "Kotlin", "Java", "Python"]
let wordLenght = languages.map { $0.count }
print("Word's lenght array of languages: \(wordLenght)\n")

// Filter - за допомогою filter залиш тільки непарні числа
let randomNumbers = [1,2,3,4,5,6]
let even = randomNumbers.filter { $0 % 2 == 0}
print("Sorted even numbers: \(even)\n")

// Reduce - порахуйте суму за допомогою reduce
let random2Numbers = [ 3, 5, 7, 9]
let sum2 = random2Numbers.reduce(0, +)
print("Sum: \(sum2)\n")


// MARK: PRACTICE LEVEL - AVARAGE
struct Student {
    let name: String
    let grade: Int
}

let students = [
    Student(name: "Max", grade: 80),
    Student(name: "Anna", grade: 95),
    Student(name: "Oleh", grade: 60)
]


// за допомогою map отримаю масив лише імен
let onlyNames = students.map { $0.name }
print("Names: \(onlyNames)\n")

// за допомогою filter студентів з оцінкою > 70
let grades = students.filter { $0.grade > 70 }
print("Grades more than 70: \(grades.map(\.name))\n")

// за допомогою reduce - середню оцінку
let totalGrade = students.reduce(0) { $0 + $1.grade}
let avarageGrade = Double(totalGrade) / Double(students.count)
print("Avarage grade students: \(avarageGrade)\n")


// MARK: PRACTICE LEVEL - Advanced
extension Array {
    func myMap<T>(_ transform: (Element) -> T) -> [T] {
        var result: [T] = []
        
        for item in self {
            result.append(transform(item))
        }
        
        return result
    }
}


let points = [ 10, 20, 50, 100]
let squared = points.myMap { $0 * $0 }
print(squared)


struct ClassMates {
    let name: String
    let subjects: [String: [Double]]
    
    var avarageGrades: [String: Double] {
        return subjects.mapValues { grades in
            Double(grades.reduce(0, +)) / Double(grades.count)
        }
    }
}

struct GroupDID11 {
    var students: [ClassMates]
}


let group = GroupDID11(students: [
    ClassMates(name: "Max ", subjects: ["Math": [90,85,88], "Physics": [75,80,70]]),
    ClassMates(name: "Anna", subjects: ["Math": [60,70,80], "Physics": [55,65,60]])
    
])

for student in group.students {
    print(student.name)
    for (subject, avg) in student.avarageGrades {
        print("   \(subject): \(avg)")
    }
}
