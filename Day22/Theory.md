# 🧩 Архітектура в iOS

## 🧩 1. Що таке архітектура в iOS

**Архітектура** — це спосіб організувати код у проєкті, щоб він був:
- зрозумілий (легко читати);
- підтримуваний (легко змінювати);
- розширюваний (легко додавати новий функціонал).

В iOS найчастіше використовують:
- **MVC (Model-View-Controller)** — базова архітектура, від Apple.
- **MVVM (Model-View-ViewModel)** — сучасніша альтернатива від екосистеми Microsoft, частіше використовується у великих проєктах.

---

## 🧱 2. MVC (Model – View – Controller)

### 🔹 Основна ідея
Розділити код за ролями:
1. **Model** — дані та логіка.
2. **View** — інтерфейс користувача (UI).
3. **Controller** — посередник між Model і View.
```
     +-------------+
     |    Model    |     ←→        Дані, логіка
     +-------------+
            ↑
            |    
            ↓
     +-------------+
     |  Controller |     ←→        Посередник, керує всім
     +-------------+
            ↑
            |
            ↓
     +-------------+
     |    View     |     ←→        UI, кнопки, текст, екрани
     +-------------+
```
- 🔹 Controller знає і про View, і про Model.
- 🔹 Він сам бере дані з Model → передає у View → обробляє кліки.
- 🔹 Проблема: Controller росте, стає “Massive View Controller”.

### 1️⃣ Model
```swift
struct User {
    let name: String
    let age: Int
}
```

### 2️⃣ View — UI
```swift
// У Storyboard: UILabel, UIButton
// IBOutlet-и до ViewController
@IBOutlet weak var nameLabel: UILabel!
@IBOutlet weak var ageLabel: UILabel!
```
### 3️⃣ Controller — зв’язує все разом
```swift
class UserViewController: UIViewController {
    var user = User(name: "Максим", age: 19)

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        nameLabel.text = user.name
        ageLabel.text = "Вік: \(user.age)"
    }
}
```

**🧱 Структура зв’язку**
`Model <----> Controller <----> View`
* Controller “дивиться” у View (через IBOutlet).
* Controller “дивиться” у Model (через властивості або сервіси).
* View і Model не спілкуються напряму.

---

## 💡 3. MVVM (Model – View – ViewModel)

### 🔹 Основна ідея

Розділити логіку відображення (ViewModel) від UI (View), щоб контролер був легким.
**MVVM** →
- Model — дані.
- View — UI (екран, ViewController).
- ViewModel — логіка, яка готує дані для View.
```
     +-------------+
     |    Model    |     ←→        Дані, логіка
     +-------------+
            ↑
            |
            ↓
     +-------------+
     |  ViewModel  |     ←→        Форматує, обробляє, оновлює
     +-------------+
            ↑
            |   (binding, delegate, closure, Combine)
            ↓
     +-------------+
     |    View     |     ←→        Показує готові дані
     +-------------+
```
- 🔹 ViewModel бере дані з Model, форматує їх (наприклад, "19" → "19 років").
- 🔹 View просто показує все, не знаючи звідки воно взялося.
- 🔹 Controller (або View) стає дуже легким — тільки “екран”.

#### 🧩 Як це працює

### 1️⃣ Model
```swift
struct User {
    let name: String
    let age: Int
}
```

### 2️⃣ ViewModel
```swift
class UserViewModel {
    private let user: User

    var nameText: String {
        return "Ім’я: \(user.name)"
    }

    var ageText: String {
        return "Вік: \(user.age)"
    }

    init(user: User) {
        self.user = user
    }
}
```

### 3️⃣ View (ViewController)
```swift
class UserViewController: UIViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!

    var viewModel: UserViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    func updateUI() {
        nameLabel.text = viewModel.nameText
        ageLabel.text = viewModel.ageText
    }
}
```

**🧱 Структура зв’язку**
`Model <----> ViewModel <----> View`
* ViewModel отримує дані з Model.
* View підписується на зміни у ViewModel (через closures, delegate або Combine).
* Controller — тепер просто “контейнер”, а не головний мозок.
