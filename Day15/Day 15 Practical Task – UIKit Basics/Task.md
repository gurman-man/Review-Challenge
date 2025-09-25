# 🏗️ Day 15 Practical Task – UIKit Basics

## 🎯 Мета
Створити простий екран з наступними елементами:
- **UIView** – контейнер для елементів
- **UILabel** – відображає текст
- **UIButton** – змінює текст у UILabel при натисканні
- **UITextField** – дозволяє користувачу вводити текст для оновлення UILabel

---

## 📋 Завдання

1. Створіть новий `UIViewController` (наприклад `Day15ViewController`)  
2. Додайте на нього **UIView** як контейнер для елементів:
   - Колір фону контейнера: світло-сірий  
   - Кути заокруглені (`cornerRadius = 10`)  
3. Додайте **UILabel** у центр контейнера:
   - Початковий текст: `"Hello, UIKit!"`  
   - Колір тексту: синій  
   - Шрифт: 18 pt, medium  
4. Додайте **UITextField** під UILabel:
   - `placeholder`: `"Введіть текст"`  
   - Стиль: округлий (`roundedRect`)  
   - Колір тексту: чорний  
5. Додайте **UIButton** під UITextField:
   - Текст кнопки: `"Update Label"`  
   - Тип кнопки: `.system`  
6. Реалізуйте **логіку взаємодії**:
   - Коли користувач вводить текст у UITextField і натискає кнопку, текст у UILabel змінюється на введений текст  
   - Якщо поле порожнє, текст залишаємо без змін  

---

## 🔧 Підказка (Swift 5)

```swift
class Day15ViewController: UIViewController {

    private let containerView = UIView()
    private let label = UILabel()
    private let textField = UITextField()
    private let button = UIButton(type: .system)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        // --- Container View ---
        containerView.backgroundColor = .lightGray
        containerView.layer.cornerRadius = 10
        view.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            containerView.heightAnchor.constraint(equalToConstant: 200)
        ])

        // --- Label ---
        label.text = "Hello, UIKit!"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        label.textAlignment = .center
        containerView.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            label.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])

        // --- TextField ---
        textField.placeholder = "Введіть текст"
        textField.borderStyle = .roundedRect
        textField.textColor = .black
        containerView.addSubview(textField)
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            textField.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])

        // --- Button ---
        button.setTitle("Update Label", for: .normal)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        containerView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 15),
            button.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        ])
    }

    @objc private func buttonTapped() {
        guard let text = textField.text, !text.isEmpty else { return }
        label.text = text
        textField.text = ""
    }
}

