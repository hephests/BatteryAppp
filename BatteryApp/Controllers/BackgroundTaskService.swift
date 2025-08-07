//
//  BackgroundTaskManager.swift
//  Test
//
//  Created by Vladuslav on 07.08.2025.
//

import UIKit

final class BackgroundTaskService {
    private var backgroundTaskID: UIBackgroundTaskIdentifier = .invalid

    func beginBackgroundTask() {
        endBackgroundTask()

        backgroundTaskID = UIApplication.shared.beginBackgroundTask(withName: "BatteryTask") { [weak self] in
            self?.endBackgroundTask()
        }
    }

    func endBackgroundTask() {
        if backgroundTaskID != .invalid {
            UIApplication.shared.endBackgroundTask(backgroundTaskID)
            backgroundTaskID = .invalid
        }
    }
}
