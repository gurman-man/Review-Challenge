import UIKit

import UIKit

// Race Condition — це ситуація, коли кілька потоків одночасно змінюють одну спільну змінну,
// і результат стає непередбачуваним.

// === Приклад 1: Race Condition ===
nonisolated(unsafe) var counter = 0
// nonisolated(unsafe) — дозволяє змінювати глобальну змінну з будь-якого потоку (без захисту).

let group1 = DispatchGroup()
let queue = DispatchQueue.global()

for _ in 0..<1000 {
    group1.enter()
    queue.async {
        Thread.sleep(forTimeInterval: Double.random(in: 0.001...0.01))
        counter += 1
        group1.leave()
    }
}

group1.notify(queue: .main) {
    print("⚠️ Race Condition Result → counter =", counter) // Очікуєш 1000, але отримаєш, наприклад, 991
    
    // === Приклад 2: Усунення Race Condition (Serial Queue) ===
    nonisolated(unsafe) var counter2 = 0
    let group2 = DispatchGroup()
    let serialQueue = DispatchQueue(label: "com.example.serial")

    for _ in 0..<2000 {
        group2.enter()
        serialQueue.async {
            Thread.sleep(forTimeInterval: Double.random(in: 0.001...0.01))
            counter2 += 1
            group2.leave()
        }
    }

    group2.notify(queue: .main) {
        print("✅ Fixed (Serial Queue) Result → counter2 =", counter2) // Завжди 2000
        
        // === Приклад 3: Усунення Race Condition (NSLock) ===
        nonisolated(unsafe) var counter3 = 0
        let group3 = DispatchGroup()
        let lock = NSLock()
        let concurrentQueue = DispatchQueue.global() // 🔸 інша, конкурентна черга

        for _ in 0..<500 {
            group3.enter()
            concurrentQueue.async {
                lock.lock()
                Thread.sleep(forTimeInterval: Double.random(in: 0.001...0.01))
                counter3 += 1
                lock.unlock()
                group3.leave()
            }
        }

        group3.notify(queue: .main) {
            print("✅ Fixed (NSLock) Result → counter3 =", counter3) // Завжди 500
            
            // === Приклад 4: Race Condition через OperationQueue + DispatchGroup ===
            nonisolated(unsafe) var counter4 = 0
            let group4 = DispatchGroup()
            let queue4 = OperationQueue()
            queue4.maxConcurrentOperationCount = 5 // одночасно до 5 потоків

            for _ in 0..<1000 {
                group4.enter()
                queue4.addOperation {
                    Thread.sleep(forTimeInterval: Double.random(in: 0.001...0.01))
                    counter4 += 1
                    group4.leave()
                }
            }

            group4.notify(queue: .main) {
                print("⚠️ Race Condition (OperationQueue) Result → counter4 =", counter4)
            }
        }
    }
}



/*
 🔹 Короткий висновок:
 У цьому коді ми усуваємо race condition, створивши serial queue — вона гарантує, що збільшення counter виконується послідовно, а не одночасно з кількох потоків.
 
 DispatchGroup використовується, щоб дочекатися завершення всіх операцій, а notify викликає блок у main queue, коли всі задачі виконані.
 
 
 🧩 Підсумок:
    serialQueue → запобігає одночасному доступу до counter.
    DispatchGroup → дозволяє відслідковувати завершення всіх задач.
    notify → викликає фінальний результат після завершення всіх інкрементів.
 */
