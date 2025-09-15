import UIKit

struct Student {
    let name: String
    var testScore: Int
}

let students = [
    Student(name: "Max", testScore: 60),
    Student(name: "Misha", testScore: 88),
    Student(name: "Volodya", testScore: 81),
    Student(name: "Ivan", testScore: 77)
]

// Замикання
var topStudentFilter: (Student) -> Bool = { student in
    return student.testScore > 80
}

// Функція
func topStudentFilterF(student: Student) -> Bool {
    return student.testScore > 70
}

// Виклик
// let topStudents = students.filter(topStudentFilter)
let topStudents = students.filter { return $0.testScore > 80 }      // shorthand form ($0)

for topStudent in topStudents {
    print(topStudent.name)
}
