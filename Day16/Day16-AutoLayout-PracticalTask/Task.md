# 🏗️ Day 16 Practical Task – AutoLayout + ToDo App

## 🎯 Мета
Закріпити знання **UIStackView** та **Constraints**, інтегрувати їх у Pet Project (#1 ToDo App).  

---

## 📋 Завдання

1. **Створити чистий екран для тренування Auto Layout**
   - Додати `UIStackView` вертикально
   - Всередині stackView:
     - 2 кнопки (`UIButton`) — "Add Task", "Clear Tasks"
     - 1 label (`UILabel`) — "Tasks count: 0"
   - Використати **constraints** для розташування stackView по центру екрану з відступами від країв
   - Встановити spacing та alignment у stackView

2. **Додати логіку кнопок**
   - `"Add Task"` — додає елемент у масив `tasks` та оновлює label  
     ```swift
     tasks.append("New Task")
     label.text = "Tasks count: \(tasks.count)"
     ```
   - `"Clear Tasks"` — очищає масив і оновлює label

3. **Інтеграція у ToDo App**
   - Додати stackView із кнопками та лейблом над UITableView
   - Після додавання/очищення елементів масиву, оновлювати TableView

---

## 🔧 Підказка (Swift 5)

```swift
class Day16ViewController: UIViewController {

    private var tasks: [String] = []
    private let tasksLabel = UILabel()
    private let addButton = UIButton(type: .system)
    private let clearButton = UIButton(type: .system)
    private let stackView = UIStackView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupViews()
    }

    private func setupViews() {
        // --- Label ---
        tasksLabel.text = "Tasks count: 0"
        tasksLabel.textAlignment = .center

        // --- Buttons ---
        addButton.setTitle("Add Task", for: .normal)
        addButton.addTarget(self, action: #selector(addTask), for: .touchUpInside)

        clearButton.setTitle("Clear Tasks", for: .normal)
        clearButton.addTarget(self, action: #selector(clearTasks), for: .touchUpInside)

        // --- StackView ---
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.alignment = .center
        stackView.addArrangedSubview(tasksLabel)
        stackView.addArrangedSubview(addButton)
        stackView.addArrangedSubview(clearButton)
        view.addSubview(stackView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20)
        ])
    }

    @objc private func addTask() {
        tasks.append("New Task")
        tasksLabel.text = "Tasks count: \(tasks.count)"
    }

    @objc private func clearTasks() {
        tasks.removeAll()
        tasksLabel.text = "Tasks count: 0"
    }
}

