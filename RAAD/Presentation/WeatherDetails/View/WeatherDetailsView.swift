//
//  WeatherDetailsView.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI
import SwiftUI

struct WeatherDetailsView: View {

    let hours: [HourlyForecastModel]

    @State private var selectedHour: HourlyForecastModel?

    init(hours: [HourlyForecastModel]) {
        self.hours = hours
        _selectedHour = State(initialValue: hours.first)
    }

    var body: some View {

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
        .navigationBarTitleDisplayMode(.inline)
    }
}
