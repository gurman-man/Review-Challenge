//
//  ViewController.swift
//  userDefaults
//
//  Created by mac on 15.10.2025.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var onOffSwitch: UISwitch!
    @IBOutlet weak var onOffLabel: UILabel!
    @IBOutlet weak var themeSegment: UISegmentedControl!
    
    // Просте сховище для збереження невеликих даних користувача
    let userDefault = UserDefaults.standard
    
    // Ключі для збереження налаштувань
    let ON_OFF_KEY = "onOffKey"
    let THEME_KEY = "themeKey"
    
    // Значення тем
    let DARK_THEME = "darkTheme"
    let LIGHT_THEME = "lightTheme"
    let RED_THEME = "redTheme"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkSwitchState()
        updateTheme()
    }
    
    // Зчитує стан перемикача (ON/OFF) із UserDefaults
    func checkSwitchState() {
        if (userDefault.bool(forKey: ON_OFF_KEY)) {
            onOffSwitch.setOn(true, animated: true)
            onOffLabel.text = "ON"
        } else {
            onOffSwitch.setOn(false, animated: true)
            onOffLabel.text = "OFF"
        }
    }
    
    
    // Зчитує поточну тему та оновлює інтерфейс
    func updateTheme() {
        guard let theme = userDefault.string(forKey: THEME_KEY) else { return }
        
        switch theme {
        case LIGHT_THEME:
            themeSegment.selectedSegmentIndex = 0
            view.backgroundColor = UIColor.white
        case DARK_THEME:
            themeSegment.selectedSegmentIndex = 1
            view.backgroundColor = UIColor.darkGray
        case RED_THEME:
            themeSegment.selectedSegmentIndex = 2
            view.backgroundColor = UIColor.red
        default:
            view.backgroundColor = UIColor.clear
        }
    }

    // Зберігає новий стан перемикача в UserDefaults
    @IBAction func switchChanged(_ sender: Any) {
        if (onOffSwitch.isOn)
        {
            // збереження
            userDefault.set(true, forKey: ON_OFF_KEY)
            onOffLabel.text = "ON"
        }
        else
        {
            userDefault.set(false, forKey: ON_OFF_KEY)
            onOffLabel.text = "OFF"
        }
    }
    
    // Зберігає вибрану тему в UserDefaults і миттєво оновлює вигляд
    @IBAction func segmentChanged(_ sender: Any) {
        switch themeSegment.selectedSegmentIndex {
        case 0:
            userDefault.set(LIGHT_THEME, forKey: THEME_KEY)
        case 1:
            userDefault.set(DARK_THEME, forKey: THEME_KEY)
        case 2:
            userDefault.set(RED_THEME, forKey: THEME_KEY)
        default:
            userDefault.set(LIGHT_THEME, forKey: THEME_KEY)
        }
        
        updateTheme()   // Оновлюємо UI після зміни
    }
    
}

