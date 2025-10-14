//
//  Request.swift
//  CurrencyConverter
//
//  Created by mac on 13.10.2025.
//

/*
 
{
"meta": {
    "last_updated_at": "2022-01-01T23:59:59Z"
},
"data": {
    "AED": {
        "code": "AED",
        "value": 3.67306
    },
    "AFN": {
        "code": "AFN",
        "value": 91.80254
    },
    "ALL": {
        "code": "ALL",
        "value": 108.22904
    },
    "AMD": {
        "code": "AMD",
        "value": 480.41659
    },
    "...": "150+ more currencies"
    }
 }
 
*/

import Foundation

// 🔹 Запит
struct CurrencyResponse: Decodable {
    let meta: Meta
    let data: [String: CurrencyData]
}

struct Meta: Codable {
    let last_updated_at: String
}

struct CurrencyData: Decodable {
    let code: String
    let value: Double
}
