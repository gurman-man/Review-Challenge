import Foundation
import UIKit

// OPERATION QUEUE
let mainQueue = OperationQueue.main
let customQueue = OperationQueue()
customQueue.maxConcurrentOperationCount = 30

customQueue.addOperation {
    
}

let fetchIdOperation = Operation()
fetchIdOperation.cancel()

let fetchUserPhotoWithIdOperation = Operation()

fetchUserPhotoWithIdOperation.addDependency(fetchIdOperation)

customQueue.addOperation(fetchUserPhotoWithIdOperation)


// DISPATCH QUEUE
// MARK: goalOne - навитися гурпувати асинхронні задачі та використоввати - notify -
let group = DispatchGroup() // 0 - лічильник
let queue = DispatchQueue.global()

for i in 1...5 {
    group.enter()  // Добавляється задача в групу, лічильник = 1
    queue.async {
        print("Task \(i) started")
        Thread.sleep(forTimeInterval: Double.random(in: 0.1...0.5)) // cтворюєм невелику затримку
        print("Task \(i) finished")
        group.leave() // виходимо з групи
    }
}

// notify - викликається коли всі завдання завершились
group.notify(queue: .main) { // 0
    print("All tasks completed (Level 1)\n")
}


// MARK: goalTw0 - зрозуміти, як синхронізувати асихронні задачі і повернутись у головний потік.
let group2 = DispatchGroup()
let imageQueue = DispatchQueue.global()
let images = ["Image1", "Image2", "Image3"]

// скорочений синтаксис
for img in images {
    imageQueue.async(group: group2) {
        print("Downloading \(img)...")
        Thread.sleep(forTimeInterval: Double.random(in: 0.5...1.5))
        print("\(img) downloaded")
    }
}

group2.notify(queue: .main) {
    print("All images downloaded (Level 2)\n")
}

