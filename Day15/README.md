# 🖌️ Day 15 – UIKit Basics (UIView, UILabel, UIButton, UITextField)

---

## 1️⃣ **UIView**
**Що це:** базовий контейнер для інших елементів UI.

**Основні моменти:**
- `frame`   — позиція та розмір у superview  
- `bounds`  — розмір та координати всередині самого view  
- Додаємо дочірні елементи через:  
```swift
view.addSubview(subview)
```
Можна налаштовувати:
- фон: `backgroundColor`
- обводку / кути: `layer.borderWidth`, `layer.cornerRadius`
- жести: `gestureRecognizers`

---

## 2️⃣ **UILabel**
**Що це:** відображає текст на екрані.

**Основні властивості:**
- `text`            — текст
- `textColor`       — колір
- `font`            - шрифт 
- `textAlignment`   — вирівнювання
- `numberOfLines`   — кількість рядків

**Особливості:** автоматично підлаштовує свій розмір (`intrinsicContentSize`)
```swift
let label = UILabel()
label.text = "Hello, UIKit!"
label.textColor = .systemBlue
label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
label.textAlignment = .center
```

---

## 3️⃣ **UIButton**
**Що це:** інтерактивна кнопка.

**Основні властивості:**
- `setTitle(_:for:)` — текст
- `setTitleColor(_:for:)`, `titleLabel?.font` — стилізація

**Target-Action (натискання кнопки):**
```swift
let button = UIButton(type: .system)
button.setTitle("Tap me", for: .normal)
button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)

@objc func buttonTapped() {
    print("Button pressed!")
}
```

**Типи кнопок:** `.system`, `.custom`
**Стани:** .normal, `.highlighted`, `.disabled`, `.selected`

---

##4️⃣ **UITextField**
**Що це:** поле для введення тексту (однорядкове).

**Основні властивості:**
- `text`, `placeholder`, `textСщлщк`, `font`, `textAlignment`
- `isSecureTextEntry` — режим пароля

**Делегат:** `UITextFieldDelegate` — обробка початку/кінця редагування та Return key
**Події:** `.editingChanged`, `.editingDidEndOnExit`
**Клавіатура:** `keyboardType`, `returnKeyType`
```swift
let textField = UITextField()
textField.placeholder = "Enter name"
textField.textColor = .black
textField.font = UIFont.systemFont(ofSize: 16)
textField.borderStyle = .roundedRect
textField.keyboardType = .default
```

---

##💡 Підсумок:##
**UIView** → контейнер
**UILabel** → текст
**UIButton** → натискання
**UITextField** → введення тексту
