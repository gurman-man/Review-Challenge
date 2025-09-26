# 🖌️ Day 16 – AutoLayout Basics (UIStackView, Constraints)

---

## 1️⃣ **UIStackView**
**Що це:** контейнер, який автоматично розміщує елементи по **вертикалі** або **горизонталі**.

**Основні моменти:**
- Спрощує Auto Layout (не треба вручну задавати constraints для кожного елемента)
- `axis` – напрямок (`.horizontal` / `.vertical`)
- `spacing` – відстань між елементами
- `alignment` – вирівнювання (`.fill`, `.center`, `.leading`, `.trailing`)
- `distribution` – розподіл простору (`.fill`, `.fillEqually`, `.equalSpacing`, `.equalCentering`)

**Додаємо елементи:**
```swift
stackView.addArrangedSubview(yourView)
```
**Ключова ідея:** StackView не малює нічого – він лише керує розміщенням своїх arrangedSubviews.

---

## 2️⃣ **Constraints (Auto Layout)**
**Що це:** правила, які визначають позицію та розмір UI-елементів.

**Основні моменти:**

- Auto Layout адаптує UI під різні екрани
- Constraints – це відносини між елементами:
    - `leading`, `trailing`, `top`, `bottom`– відступи
    - `centerX`, `centerY` – центрування
    - `width`, `height` – розмір
- Відносини можуть бути: **рівні**, **більше або рівні**, **менше або рівні**

**Створення constraints програмно:**
```swift
yourView.translatesAutoresizingMaskIntoConstraints = false

NSLayoutConstraint.activate([
    yourView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
    yourView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
    yourView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
    yourView.heightAnchor.constraint(equalToConstant: 50)
])
```
##💡 Підсумок:
**UIStackView** → контейнер для упорядкування елементів
**Constraints** → правила розміщення та розміру
