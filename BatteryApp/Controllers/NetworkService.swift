//
//  NetworkManager.swift
//  Test
//
//  Created by Vladuslav on 07.08.2025.
//

import Foundation

final class NetworkService {
    func sendBatteryStatus(_ status: BatteryStatus, completion: ((String) -> Void)? = nil) {
//        створюємо url якщо не створюється Надсилаємо запит на сповіщення і передаємо текст
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            completion?("❌ Invalid URL")
            return
        }
        
        // Серіалізуємо модель у JSON + Кодуємо у base64 + запит на сповіщення
        guard let jsonData = try? JSONEncoder().encode(status),
              let base64String = jsonData.base64EncodedString().data(using: .utf8) else {
            completion?("❌ Failed to encode battery status")
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = base64String
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

//        надсилаємо на сервер + сповіщення з помилкою
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error{
                completion?("❌ Network error: \(error.localizedDescription)")
            }else{
                completion?("✅ Battery status sent successfully")
            }
        }.resume()
    }
}
