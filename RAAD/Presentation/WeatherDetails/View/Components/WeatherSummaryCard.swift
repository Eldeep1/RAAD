//
//  WeatherSummarySection.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import SwiftUI

struct WeatherSummaryCard: View {
    @EnvironmentObject var themeManager: ThemeManager

    let hour: HourlyForecastModel

    var body: some View {
        let colors = themeManager.currentTheme.colors

        VStack(alignment: .leading, spacing: 16) {

            Text("CURRENT CONDITIONS")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(colors.secondaryText)

            HStack(alignment: .bottom) {

                Text("\(Int(hour.temperature))°")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundStyle(colors.primaryText)

                Spacer()
            }

            Text(hour.condition)
                .font(.title3)
                .foregroundStyle(colors.primaryText)

            Text("Rain Chance \(hour.rainChance)%")
                .foregroundStyle(colors.secondaryText)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(colors.cardBackground)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
}
