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


