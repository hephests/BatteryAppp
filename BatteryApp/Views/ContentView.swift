//
//  ContentView.swift
//  Test
//
//  Created by Vladuslav on 07.08.2025.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = BatteryMonitorViewModel()
    @State private var MonitoringStatus: Bool = false

    var body: some View {
        VStack(spacing: 30) {
            Text("🔋 Battery Level: \(Int(viewModel.batteryLevel) == -1 ? "Perfect" : "\(Int(viewModel.batteryLevel) * 100)%")")
                .font(.largeTitle)

            Button("Start Monitoring") {
//                Починаємо моніторинг
                viewModel.startMonitoring()
                withAnimation{
                    MonitoringStatus = true
                }
            }
            .buttonStyle(.borderedProminent)

            Text(MonitoringStatus ? "Monitoring is running..." : "Monitoring stopped...")
                .foregroundStyle(MonitoringStatus ? Color.green : Color.red)
            
            Button("Stop Monitoring") {
//                Зупиняємо моніторинг
                viewModel.stopMonitoring()
                withAnimation{
                    MonitoringStatus = false
                }
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
