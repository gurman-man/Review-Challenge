//
//  ViewController.swift
//  NoteAppCoreData
//
//  Created by mac on 19.10.2025.
//

import UIKit
import CoreData

class NoteDetailVC: UIViewController {
    
    @IBOutlet weak var titleTF: UITextField!
    @IBOutlet weak var descTV: UITextView!
    
    var selectedNote: Note? = nil  // якщо nil → створюємо нову, якщо ні → редагуємо існуючу
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (selectedNote != nil) {
            // якщо редагуємо — заповнюємо поля поточними даними
            titleTF.text = selectedNote?.title
            descTV.text = selectedNote?.desc
        }
    }
    
    
    // 💾 ЗБЕРЕЖЕННЯ або ОНОВЛЕННЯ нотатки
    @IBAction func saveAction(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("❗️Не вдалося отримати AppDelegate")
            return
        }
        
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        
        if (selectedNote == nil) {
            // 🟢 Створюємо нову нотатку
            guard let entity = NSEntityDescription.entity(forEntityName: "Note", in: context) else { return }
            let newNote = Note(entity: entity, insertInto: context)
            
            newNote.id = Int32(noteList.count)
            newNote.title = titleTF.text
            newNote.desc = descTV.text
            
            do {
                try context.save()          // зберігає зміни в Core Data
                noteList.append(newNote)    // додаємо в локальний список
                navigationController?.popViewController(animated: true)
            } catch {
                print("context save error")
            }
        } else {
            // ✏️ Редагування існуючої нотатки
            selectedNote?.title = titleTF.text
            selectedNote?.desc = descTV.text
            
            do {
                try context.save()  // 💾 зберігаємо зміни в Core Data
                navigationController?.popViewController(animated: true)
            } catch {
                print("❌ Update failed: \(error.localizedDescription)")
            }
        }
    }
    
    // ❌ М'ЯКЕ ВИДАЛЕННЯ — просто додаємо дату видалення
    @IBAction func DeleteNote(_ sender: Any) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            print("❗️Не вдалося отримати AppDelegate")
            return
        }
        
        let context: NSManagedObjectContext = appDelegate.persistentContainer.viewContext
        guard let noteToEdit = selectedNote else { return }

        noteToEdit.deletedDate = Date()  // помічаємо як "видалено"
        
        do {
            try context.save()
            navigationController?.popViewController(animated: true)
        } catch {
            print("❌ Update failed: \(error.localizedDescription)")
        }
    }
    
}

