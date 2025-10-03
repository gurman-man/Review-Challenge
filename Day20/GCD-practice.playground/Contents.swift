import UIKit

// MARK: LEVEL1 - BASICS -

//func sumOfNumbers(_ n: Int) -> Int {
//    return (1...n).reduce(0, +)
//}
//
//DispatchQueue.global(qos: .background).async {
//    let result = sumOfNumbers(1000)
//    
//    DispatchQueue.main.async {
//        print("---- TASK 1 ----")
//        print("Sum of numbers :", result)
//    }
//}


//print("---- TASK 2 ----")
//let serial = DispatchQueue(label: "example.serial")
//
//serial.async {
//    print(1)
//}
//
//serial.async {
//    print(2)
//}
//
//serial.async {
//    print(3)
//}

//print("---- TASK 3 ----")
//let concurrent = DispatchQueue(label: "example.concurrent", attributes: .concurrent)
//
//concurrent.async {
//    print("Task1 finished immediately")
//}
//
//concurrent.async {
//    sleep(3)
//    print("Task2 finished after 3 sec")
//}
//
//concurrent.async {
//    sleep(1)
//    print("Task3 finished after 1 sec")
//}

/*
📌 Короткий висновок:

🔹 Serial Queue (послідовна черга)
Завдання виконуються строго одне за одним.
Наступне завдання не почнеться, доки попереднє не завершиться.
Порядок гарантовано зберігається.
Використовується, коли потрібна безпека доступу до спільних даних або важливий порядок.

 1. Label
 Label (мітка, наприклад "example.serial")
 Це рядок-ідентифікатор черги.
 Використовується для відлагодження (debugging), щоб у Xcode / Instruments ти бачив, яка саме черга виконує завдання.
 Наприклад, якщо в тебе кілька власних черг, у логах буде легше зрозуміти, звідки прийшов потік.

 
🔹 Concurrent Queue (паралельна черга)
Кілька завдань можуть виконуватись одночасно на різних потоках.
Порядок виконання не гарантується (результати можуть приходити в будь-якій послідовності).
Добре підходить для фонових обчислень, завантаження даних, роботи з мережею.
 
 2. Attributes
 Це опції, які визначають поведінку черги.
 Якщо атрибути не вказувати → черга буде serial (послідовна) за замовчуванням.
 Якщо передати .concurrent → черга стане concurrent (паралельна).
*/


// MARK: LEVEl2 - async vs sync -
/*print("---- async vs sync ----")
print("Start")

// === SYNC ===
DispatchQueue.global().sync {
    print("Sync task started")
    // Імітуємо довгу задачу
    Thread.sleep(forTimeInterval: 2)   // потік блокується на 10 сек → "Sync task finished"
    print("Sync task finished")
}

print("After sync") // Цей рядок виконається тільки після завершення sync-завдання

// === ASYNC ===
DispatchQueue.global().async {
    print("Async task started")
    Thread.sleep(forTimeInterval: 2)   // "Async task started" та "Async task finished" з’являться через ~10 сек паралельно
    print("Async task finished")
}

print("After async") // Цей рядок виконається одразу, не чекаючи завершення async-завдання
// Щоб playground або скрипт не завершився раніше
RunLoop.main.run(until: Date(timeIntervalSinceNow: 3))
*/

/*
 
 Якщо викликати синхронну (sync) задачу на головному потоці, все може піти дуже погано: deadlock.
 
 DispatchQueue.main.sync {
     print("This will deadlock!")
 }
 
 🔹 Чому це deadlock:
                    1. DispatchQueue.main.sync { ... } каже:
                        «Виконай цю задачу на головному потоці та зачекай, поки вона завершиться».
                    2. Але ти вже виконуєш код на головному потоці.
                        Тобто головний потік чекає, поки задача виконається, а задача не може виконатися, бо головний потік заблокований очікуванням.
                    3. Результат:
                        потік зависає назавжди – deadlock
 
 Якщо треба виконати код на головному потоці не блокуючи його, використовуй async:
 
 DispatchQueue.main.async {
     print("This is safe")
 }
 
*/


// MARK: LEVEL3 - QoS -
print("---- QoS ----")
DispatchQueue.global(qos: .userInteractive).async {
    sleep(2)
    print(".userInteractice - work")
}

DispatchQueue.global(qos: .utility).async {
    sleep(2)
    print(".utility - work")
}

DispatchQueue.global(qos: .utility).async {
    sleep(2)
    print(".background - work")
}


