# 🧭 Підсумок

---

| **Дія** | **Що робиться** | **У якому файлі** |
|:-|:-|:-|
| 🟢 Створення | Користувач вводить текст → створюється новий Note → context.save() | NoteDetailVC |
| ✏️ Редагування | Змінюються поля об’єкта → context.save() | NoteDetailVC |
| ❌ Видалення | Не видаляємо з бази, а ставимо deletedDate = Date() | NoteDetailVC |
| 📥 Зчитування | Через fetchNotes() витягуємо всі об’єкти з бази | NoteTableView |
| 📋 Відображення | Таблиця показує всі Note, крім тих, що мають deletedDate | NoteTableView |


##  **Підключення контексту**
```swift
let appDelegate = UIApplication.shared.delegate as! AppDelegate
let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
```
**Пояснення:**
- **UIApplication.shared.delegate** — отримує доступ до **AppDelegate**, де створено **persistentContainer**.
- **persistentContainer.viewContext** — це твій "воротар" у Core Data.
Через нього ти створюєш, читаєш, редагуєш і видаляєш дані.


## **Створення нового об’єкта (Insert)**
```swift
let entity = NSEntityDescription.entity(forEntityName: "Note", in: context)
let newNote = Note(entity: entity!, insertInto: context)
newNote.title = "My first note"
newNote.text = "This is a test"
newNote.date = Date()
```
**Пояснення:**
- **entity(forEntityName:in:)** знаходить опис сутності "Note".
- **Note(...)** створює новий об’єкт, який одразу вставляється в контекст.
- Потім задаєш значення атрибутів (**title**, **text**, **date**).


## **Збереження змін (Save)**
```swift
do {
    try context.save()
    print("✅ Note saved successfully!")
} catch {
    print("❌ Failed to save note: \(error)")
}
```
**Пояснення:**
- Метод **save()** записує усі зміни з пам’яті (контексту) у базу даних (SQLite).


## **Отримання даних (Fetch)**
```swift
let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()

do {
    let notes = try context.fetch(fetchRequest)
    for note in notes {
        print("📝 \(note.title ?? "No title")")
    }
} catch {
    print("❌ Fetch failed: \(error)")
}
```
**Пояснення:**
- **Note.fetchRequest()** створює запит для отримання всіх об’єктів типу Note.
- **context.fetch(fetchRequest)** повертає масив результатів.
- Можна перебирати всі нотатки та виводити їх у консоль.


## **Видалення даних (Delete)**
```swift
let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()

do {
    let notes = try context.fetch(fetchRequest)
    if let firstNote = notes.first {
        context.delete(firstNote)
        try context.save()
        print("🗑️ Note deleted!")
    }
} catch {
    print("❌ Delete failed: \(error)")
}
```
**Пояснення:**
- Знаходимо потрібний об’єкт.
- Викликаємо **context.delete(object)**.
- Після цього обов’язково зберігаємо контекст **(save()**).


## **Оновлення (Update)**
```swift
let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()

do {
    let notes = try context.fetch(fetchRequest)
    if let note = notes.first {
        note.title = "Updated title"
        try context.save()
        print("✏️ Note updated!")
    }
} catch {
    print("❌ Update failed: \(error)")
}
```
