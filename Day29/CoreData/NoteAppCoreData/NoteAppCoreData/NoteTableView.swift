//
//  NoteTableView.swift
//  NoteAppCoreData
//
//  Created by mac on 19.10.2025.
//

import UIKit
import CoreData

public var noteList = [Note]()  // Глобальний масив — тимчасове сховище нотаток

class NoteTableView: UITableViewController {
    
    var firstLoad = true   // Ми ще жодного разу не завантажували нотатки з бази
    
    // Функція повертає лише ті нотатки, які не видалені
    func nonDeletedNotes() -> [Note] {
        var noDeleteNoteList = [Note]()
        for note in noteList {
            if (note.deletedDate == nil) {  // якщо нема дати видалення → показуємо
                noDeleteNoteList.append(note)
            }
        }
        return noDeleteNoteList
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (firstLoad) {
            firstLoad = false
            fetchNotes()        // Завантажуємо нотатки з бази Core Data
        }
    }
    
    
    // 🧠 Отримуємо дані з Core Data
    func fetchNotes() {
        // 1️⃣ Дістаємо AppDelegate — він тримає головний об’єкт Core Data: persistentContainer
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("❗️Не вдалося отримати AppDelegate")
            return
        }
        
        // 2️⃣ Контекст — це “двері” до бази даних. Через нього ми читаємо, додаємо або видаляємо дані
        let context = appDelegate.persistentContainer.viewContext
        
        // 3️⃣ Створюємо запит: “Дай усі об’єкти з таблиці Note”
        let request = NSFetchRequest<Note>(entityName: "Note")

        // 4️⃣ виконуємо запит і зберігаємо результат (усі нотатки) у масив noteList
        do {
            noteList = try context.fetch(request)
            print("✅ Notes fetched: \(noteList.count)")
        } catch {
            print("❌ Fetch failed: \(error.localizedDescription)")
        }
    }
    
    
    // 🔹 Виводимо кожну нотатку у таблицю
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let noteCell = tableView.dequeueReusableCell(withIdentifier: "noteCellID", for: indexPath) as! NoteCell
        
        let thisNote = nonDeletedNotes()[indexPath.row]
        
        noteCell.titleLabel.text = thisNote.title
        noteCell.descLabel.text = thisNote.desc
        
        return noteCell
    }
    
    // 🔹 Кількість рядків у таблиці
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return nonDeletedNotes().count
    }
    
    // 🔹 Після повернення на екран таблиці — оновлюємо дані
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    // 🔹 Коли користувач натискає на рядок — переходимо до екрана редагування
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "editNote", sender: self)
    }
    
    // 🔹 Передаємо вибрану нотатку на екран редагування
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "editNote") {
            let indexPath = tableView.indexPathForSelectedRow!
            let noteDetail = segue.destination as? NoteDetailVC
            let selectedNote = nonDeletedNotes()[indexPath.row]
            noteDetail!.selectedNote = selectedNote
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
