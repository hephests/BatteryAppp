//
//  BatteryMonitor.swift
//  Test
//
//  Created by Vladuslav on 07.08.2025.
//

import UIKit

final class BatteryService {
    init() {
        UIDevice.current.isBatteryMonitoringEnabled = true
    }

    func getBatteryLevel() -> Float {
        UIDevice.current.batteryLevel
    }
}
