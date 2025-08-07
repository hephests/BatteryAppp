//
//  NotificationController.swift
//  Test
//
//  Created by Vladuslav on 07.08.2025.
//

import UserNotifications

final class NotificationService {
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if let error = error {
                print("Notification error: \(error.localizedDescription)")
            }
        }
    }

    func sendBatteryNotification(level: Float, text: String) {
        let content = UNMutableNotificationContent()
        content.title = "Battery level: \(level)"
        content.body = text
        content.sound = .default

        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: nil)
        UNUserNotificationCenter.current().add(request)
    }
}
