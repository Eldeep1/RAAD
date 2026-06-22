//
//  HourCard.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import SwiftUI

struct HourCard: View {

    let hour: HourlyForecastModel

    let isSelected: Bool

    var body: some View {

        VStack(spacing: 16) {

            Text(hour.displayTime)
                .font(.headline)

            Image(systemName: iconName)
                .font(.title2)

            Text("\(Int(hour.temperature))°")
                .font(.title3)
                .fontWeight(.bold)
        }
        .frame(width: 95, height: 140)
        .background {

            RoundedRectangle(cornerRadius: 20)
                .fill(
                    isSelected
                    ? Color.cyan.opacity(0.15)
                    : Color(.systemGray6)
                )
        }
        .overlay {

            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    isSelected
                    ? Color.cyan
                    : Color.clear,
                    lineWidth: 2
                )
        }
    }

    private var iconName: String {

        let text = hour.condition.lowercased()

        if text.contains("rain") {
            return "cloud.rain"
        }

        if text.contains("storm") {
            return "cloud.bolt.rain"
        }

        if text.contains("sun") {
            return "sun.max"
        }

        return "cloud"
    }
}
