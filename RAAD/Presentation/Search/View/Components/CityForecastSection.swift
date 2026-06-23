//
//  CityForecastSection.swift
//  RAAD
//
//  Created by depo on 23/06/2026.
//

import SwiftUI

struct CityForecastSection: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var viewModel: CityWeatherViewModel

    var body: some View {
        VStack(spacing: 12) {
            ForEach(
                Array(viewModel.forecast.enumerated()),
                id: \.element.date
            ) { index, forecast in
                NavigationLink {
                    WeatherDetailsView(
                        hours: viewModel.hourlyForecastByDay[safe: index] ?? [],
                        isToday: index == 0
                    )
                    .environmentObject(themeManager)
                } label: {
                    ForecastCardView(
                        day: forecast.date,
                        temperature: "\(Int(forecast.temperature))°",
                        condition: forecast.condition,
                        icon: "cloud.fill"
                    )
                }
            }
        }
    }
}
