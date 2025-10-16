import UIKit

//    .userDomainMask → /Users/ім'яКористувача/Documents (область користувача)
//    .systemDomainMask → системні директорії macOS
//    .networkDomainMask → мережеві ресурси
//    .localDomainMask → локальні ресурси, спільні для всіх користувачів

// MARK: Завдання 1 - створення файлу -
// Мета: навчитися створювати і записувати текст у файл
let fm = FileManager.default

let path = fm.urls(for: .documentDirectory, in: .userDomainMask)[0]  // отримуємо шлях до папки Documents
let file = path.appendingPathComponent("note.txt")                   // створюємо файл note.txt

try "Hello FileManager!".write(to: file, atomically: true, encoding: .utf8)    // збережи текст - Hello FileManager! у UTF-8.

// 🧭 Вивести шлях у консоль
print("Файл збережено тут: \(file.path)\n")


// MARK: Завдання 2: - Читання файлу -
// Мета: вчитати текст із файлу.
let content = try String(contentsOf: file, encoding: .utf8)
print("Його вміст: \(content)\n")


// MARK: Завдання 3: - Видалення файлу -
// Мета: навчитися перевіряти існування та видаляти файли.
print("Файл існує перед видаленням:", fm.fileExists(atPath: file.path))
if fm.fileExists(atPath: file.path) {
    try fm.removeItem(at: file)
}
print("Файл існує перед видаленням:", fm.fileExists(atPath: file.path),"\n")


// MARK: Завдання 4: - Створення папки і кількох файлів -
// Мета: навчитися створювати структуру папок і записувати дані в кілька файлів.
let folder = path.appendingPathComponent("My notes") // Додаємо до папки Documents власну папку "My notes"
try fm.createDirectory(at: folder, withIntermediateDirectories: true) // Створюємо цю папку (якщо її ще не існує)

for i in 1...3 {
    let file = folder.appendingPathComponent("note\(i).txt")
    try "Text \(i)".write(to: file, atomically: true, encoding: .utf8)
}
print("Файли створено у папці: \(folder.path)\n")


// MARK: Завдання 5: - Вивести список файлів у папці -
// Мета: навчитися отримувати перелік усіх файлів у директорії.
let files = try fm.contentsOfDirectory(atPath: folder.path)
print("Файли в папці My notes: \(files)\n")


// MARK: - Завдання 6: Збереження масиву об’єктів -
// Мета: навчитися зберігати структури в JSON-файл за допомогою Encodable

struct Task: Codable {
    let name: String
    var isDone: Bool
}

let tasks = [
    Task(name: "Buy milk", isDone: false),
    Task(name: "Go gym", isDone: true)
]

let encoder = JSONEncoder()
let encodedData = try encoder.encode(tasks)
let jsonFile = path.appendingPathComponent("tasks.json", conformingTo: .json)    // шлях до файлу tasks.json
try encodedData.write(to: jsonFile)
print("JSON файл збережено тут: \(jsonFile.path)\n")


// MARK: - Завдання 7: - Прочитати файл у форматі .json -
let savedData = try Data(contentsOf: jsonFile)
let jsonString = String(data: savedData, encoding: .utf8)
print(jsonString ?? "❌ Помилка перетворення у String")
print("\n")

// MARK: Завдання 8: - Зчитування масиву з JSON -
// Мета: відновити об’єкти з файлу за допомогою Decodable
let decoder = JSONDecoder()
let decodedData = try Data(contentsOf: jsonFile)
let decodedFile = try decoder.decode([Task].self, from: decodedData)
decodedFile.forEach { print($0.name, " ", $0.isDone) }
print("\n")

// MARK: Завдання 9: - "Local Notes App" -
// Мета: змоделювати міні-додаток для збереження нотаток.

enum DiffError: LocalizedError {
    case noAccess
    case encodingFailed
    case decodingFailed
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .noAccess:
            return "No access to directory - 'Documents'"
        case .encodingFailed:
            return "⚠️ Data not saved (encoding failed)"
        case .decodingFailed:
            return "🚫 Data not found or corrupted (decoding failed)"
        case .unknown:
            return "unknown error"
        }
    }
}

struct Note: Codable {
    let title: String
    let text: String
}

let notesJsonFile = path.appendingPathComponent("MaxNotes.json", conformingTo: .json)  // додали файл у Documents


func saveNotes(_ notes: [Note]) {
    do {
        let encodedNotes = try? JSONEncoder().encode(notes)  // закодували дані у json
        try encodedNotes?.write(to: notesJsonFile)   // Отримані дані записуєш у файл
        print("Successfulдy saved notes to file.")
    } catch {
        print(DiffError.encodingFailed.errorDescription ?? DiffError.unknown)
    }
}


func loadNotes() -> [Note] {
    do {
        let data = try Data(contentsOf: notesJsonFile)
        let decodedNotes = try JSONDecoder().decode([Note].self, from: data)
        return decodedNotes
    } catch {
        print(DiffError.decodingFailed.errorDescription ?? DiffError.unknown)
        return []
    }
}

var notes = [
    Note(
        title: "My favourite books",
        text: """
              book: WILL - Mark Manson;
              book: Cod da Vinci - Dan Brown;
              book: Shining - Stephan King
              """
    ),
    Note(
        title: "Shopping List",
        text: """
              Sneaker: DC SHOES COURT GRAFFIK WHITE/DARK;
              Puffer: Carhartt
              """
    )
]

saveNotes(notes)
let loadedNotes = loadNotes()

for note in loadedNotes {
    print("📌 Title: \(note.title)")
    print("Text:\n\(note.text)\n")
}
