//
//  BatteryMonitorVM.swift
//  Test
//
//  Created by Vladuslav on 07.08.2025.
//

import Foundation
import UIKit

final class BatteryMonitorViewModel: ObservableObject {
    @Published var batteryLevel: Float = 0.0

    private let batteryService = BatteryService()
    private let networkService = NetworkService()
    private let notificationService = NotificationService()
    private let backgroundTaskService = BackgroundTaskService()

    private var timer: Timer?

    init() {
        notificationService.requestPermission()
        UIDevice.current.isBatteryMonitoringEnabled = true
        batteryLevel = batteryService.getBatteryLevel()
    }

    func startMonitoring() {
//        Продовжуємо фоновий час програми
        backgroundTaskService.beginBackgroundTask()
//        Запитуємо у девайсе рівень батареї (в симулятяорі -1)
        batteryLevel = batteryService.getBatteryLevel()

//        Таймер на 2 хв зчитує та надсилає батарею
        timer = Timer.scheduledTimer(withTimeInterval: 120, repeats: true) { [weak self] _ in
            self?.collectAndSend()
        }
        timer?.tolerance = 10
//        запускаємо функцію яка надішле дані на сервер та сповіщення
        collectAndSend()
    }

//    Зупиняємо активований таймер і виключаємо BackgroundTask
    func stopMonitoring() {
        timer?.invalidate()
        timer = nil
        backgroundTaskService.endBackgroundTask()
    }

//    Надсилаємо Дані + сповіщення
    private func collectAndSend() {
        batteryLevel = batteryService.getBatteryLevel()
        let status = BatteryStatus(level: batteryLevel, timestamp: Date())
//        Надсилаємо дані після цього сповіщення
        networkService.sendBatteryStatus(status) { message in
            self.notificationService.sendBatteryNotification(level: status.level, text: message)
        }
    }
}
