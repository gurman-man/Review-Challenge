//
//  CurrencyVC.swift
//  CurrencyConverter
//
//  Created by mac on 13.10.2025.
//

import UIKit

class CurrencyVC: UIViewController, UITextFieldDelegate {
    
    // MARK: - UI Elements
    private let amountTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Sum"
        tf.borderStyle = .roundedRect
        tf.keyboardType = .decimalPad
        return tf
    }()
    
    private let fromCurrencyTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "From"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let toCurrencyTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "To"
        tf.borderStyle = .roundedRect
        return tf
    }()
    
    private let convertButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Convert", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.tintColor = .white
        btn.layer.cornerRadius = 8
        return btn
    }()
    
    private let resultLabel: UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .center
        lbl.font = .systemFont(ofSize: 20, weight: .bold)
        lbl.text = "Result"
        lbl.numberOfLines = 0
        return lbl
    }()
    
    // Щоб користувач не вводив валюту вручну — ти робиш UIPickerView:
    private let pickerView = UIPickerView()
    private let currencies = ["USD", "EUR", "GBP", "UAH", "JPY", "CAD"]
    private var activeCurrencyTextField: UITextField?
    
    
    // MARK: - Currency Manager
    private let currencyManager = CurrencyManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Converter"
        
        view.backgroundColor = .white
        convertButton.addTarget(self, action: #selector(convertTapped), for: .touchUpInside)
        
        fromCurrencyTextField.delegate = self
        toCurrencyTextField.delegate = self
        
        setupLayout()
        setupPicker()
    }
    
    // MARK: - Layout
    private func setupLayout() {
        let stack = UIStackView(arrangedSubviews: [
            amountTextField,
            fromCurrencyTextField,
            toCurrencyTextField,
            convertButton,
            resultLabel
        ])
        
        stack.axis = .vertical
        stack.spacing = 20
        stack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            stack.widthAnchor.constraint(equalToConstant: 250)
        ])
        
        convertButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    // MARK: - Picker
    private func setupPicker() {
        pickerView.delegate = self      // говорить UIPickerView скільки компонентів і рядків буде
        pickerView.dataSource = self    // відповідає за що показувати в кожному рядку і що робити при виборі.
        
        // коли користувач натискає на текстове поле, замість клавіатури з’являється “коліщатко”
        fromCurrencyTextField.inputView = pickerView
        toCurrencyTextField.inputView = pickerView
        
        
        // Це верхня панель над UIPickerView
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // Кнопка Done дозволяє закрити picker після вибору значення.
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneTapped))
        toolbar.setItems([doneButton], animated: true)
        
        fromCurrencyTextField.inputAccessoryView = toolbar
        toCurrencyTextField.inputAccessoryView = toolbar
    }
    
    @objc private func doneTapped() {
         activeCurrencyTextField?.resignFirstResponder()
     }
    
    // MARK: - Convert
    @objc private func convertTapped() {
        guard
            let amountText = amountTextField.text, let amount = Double(amountText),
            let from = fromCurrencyTextField.text, !from.isEmpty,
            let to = toCurrencyTextField.text, !to.isEmpty
        else {
            resultLabel.text = "Enter all data"
            return
        }
        resultLabel.text = "Loading..."
        
        // виконання нашого замикання у СurrencyManager
        currencyManager.convertCurrency(from: from, to: to, amount: amount) { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                    
                    // Успішно отримали число конвертованої валюти
                    // тут міститься значення типу Double (converted), яке ми отримали з API
                case .success(let converted):
                    let rounded = String(format: "%.2f", converted) // 2 знаки після коми
                    self?.resultLabel.text = "\(amount) \(from) = \(rounded) \(to)"
                    
                    // Сталася помилка (NetWorkError або інша)
                    // тут міститься об’єкт помилки, який реалізує Error
                case .failure(let error):
                    self?.resultLabel.text = "Error: \(error.localizedDescription)"
                }
            }
        }
    }
    
}

// MARK: - UIPickerViewDelegate, UIPickerViewDataSource
extension CurrencyVC: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { 1 }   // одна колонка
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        currencies.count
    }
    
    // Відповідає за візуальне відображення кожного елемента списку
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        currencies[row]
    }
    
    // Виконується після того, як користувач прокрутив і вибрав рядок, оновлює текст у TextField
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        activeCurrencyTextField?.text = currencies[row]
    }
    // Зберігає, яке поле зараз активне (From або To)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        // UIPickerView обирає значення і записує його в правильне поле через
        activeCurrencyTextField = textField
    }
}
