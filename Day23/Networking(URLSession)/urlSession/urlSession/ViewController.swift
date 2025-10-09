//
//  ViewController.swift
//  urlSession
//
//  Created by mac on 09.10.2025.
//

import UIKit

class ViewController: UIViewController {
    private let networkManager = NetworkManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        networkManager.sendRequest(query: "car")
    }


}

