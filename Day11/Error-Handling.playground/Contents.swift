import UIKit

enum NetworkError: Error {
    // види помилок
    case badURL
    case noInternet
    case noData
}

// Error handling
// Функція що повертає помилку
func sendRequest(url: String) throws -> String {
    if url == "google" {
        return "OK"
    } else {
        // кинь помилку
        throw NetworkError.badURL
    }
}

// Виклик 1 - keyword: do - catch
// do       - виконай код
// catch    - кинь помилку якщо щось не так
do {
    let reqResult = try sendRequest(url: "googe")
    print(reqResult)
} catch NetworkError.badURL {
    print("bad url")
} catch NetworkError.noData {
    print("no data")
} catch NetworkError.noInternet {
    print("no internet")
}


// Виклик 2 - keyword: try
//let reqResult = try? sendRequest(url: "google")
//print(reqResult ?? "error")
