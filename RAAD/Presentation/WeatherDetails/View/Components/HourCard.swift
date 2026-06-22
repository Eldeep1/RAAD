//
//  HourCard.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import SwiftUI

struct HourCard: View {
    @EnvironmentObject var themeManager: ThemeManager

    let hour: HourlyForecastModel

    let isSelected: Bool

    var body: some View {
        let colors = themeManager.currentTheme.colors

        VStack(spacing: 16) {

            Text(hour.displayTime)
                .font(.headline)
                .foregroundStyle(colors.primaryText)

            Image(systemName: iconName)
                .font(.title2)
                .foregroundStyle(isSelected ? colors.accent : colors.secondaryText)

            Text("\(Int(hour.temperature))°")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundStyle(colors.primaryText)
        }
        .frame(width: 95, height: 140)
        .background {

            RoundedRectangle(cornerRadius: 20)
                .fill(
                    isSelected
                    ? colors.accent.opacity(0.15)
                    : colors.cardBackground
                )
        }
        .overlay {

            RoundedRectangle(cornerRadius: 20)
                .stroke(
                    isSelected
                    ? colors.accent
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
