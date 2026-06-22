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

    init(hours: [HourlyForecastModel], isToday: Bool) {
        self.hours = hours

        if isToday {
            // Find the hour entry whose time matches the current clock hour
            let currentHour = Calendar.current.component(.hour, from: Date())
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm"

            let match = hours.first { model in
                guard let date = formatter.date(from: model.time) else { return false }
                return Calendar.current.component(.hour, from: date) == currentHour
            }
            _selectedHour = State(initialValue: match ?? hours.first)
        } else {
            // Other days: nothing pre-selected
            _selectedHour = State(initialValue: nil)
        }
    }

    var body: some View {
        let colors = themeManager.currentTheme.colors

        ScrollView {

            VStack(spacing: 20) {

                // Summary + metrics only appear once a card is tapped
                if let selected = selectedHour {
                    WeatherSummaryCard(hour: selected)
                }

                // Hour picker is always visible so the user can make a selection
                HourSelectorView(
                    hours: hours,
                    selectedHour: $selectedHour
                )

                if let selected = selectedHour {
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
