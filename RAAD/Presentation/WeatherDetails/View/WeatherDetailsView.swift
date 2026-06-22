//
//  WeatherDetailsView.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

struct WeatherDetailsView: View {
    @EnvironmentObject var themeManager: ThemeManager

    let hours: [HourlyForecastModel]

    @State private var selectedHour: HourlyForecastModel?

    init(hours: [HourlyForecastModel]) {
        self.hours = hours
        _selectedHour = State(initialValue: hours.first)
    }

    var body: some View {
        let colors = themeManager.currentTheme.colors

        ScrollView {

            VStack(spacing: 20) {

                if let selected = selectedHour {

                    WeatherSummaryCard(hour: selected)

                    HourSelectorView(
                        hours: hours,
                        selectedHour: $selectedHour
                    )

                    WeatherDetailsMetricsGrid(hour: selected)
                }
            }
            .padding()
        }
        .background(colors.background)
        .foregroundStyle(colors.primaryText)
        .navigationBarTitleDisplayMode(.inline)
    }
}
