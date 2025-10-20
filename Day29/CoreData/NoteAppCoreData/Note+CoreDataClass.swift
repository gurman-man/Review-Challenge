//
//  Note+CoreDataClass.swift
//  NoteAppCoreData
//
//  Created by mac on 19.10.2025.
//
//

import Foundation
import CoreData

// Це клас, який представляє нашу сутність (таблицю) Note
@objc(Note)
public class Note: NSManagedObject {}

extension Note {
    // Поля, які зберігаються у Core Data
    @NSManaged public var id: Int32
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var deletedDate: Date?
}

extension Note : Identifiable {

}
