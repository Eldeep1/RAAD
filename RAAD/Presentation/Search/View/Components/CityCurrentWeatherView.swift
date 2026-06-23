//
//  CityCurrentWeatherView.swift
//  RAAD
//
//  Created by depo on 23/06/2026.
//

import SwiftUI


struct CityCurrentWeatherView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var viewModel: CityWeatherViewModel

    var body: some View {
        let colors = themeManager.currentTheme.colors

        VStack(spacing: 8) {
            Text(viewModel.cityName)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundStyle(colors.primaryText)

            Text(viewModel.country)
                .font(.caption)
                .foregroundStyle(colors.secondaryText)

            if let w = viewModel.weather {
                if !viewModel.forecast.isEmpty {
                    Text(viewModel.forecast[0].date)
                        .font(.caption2)
                        .foregroundStyle(colors.accent)
                }

                Image(systemName: "cloud.sun.fill")
                    .font(.title2)
                    .foregroundStyle(.cyan)

                Text("\(Int(w.temperature))°")
                    .font(.system(size: 54, weight: .bold))
                    .foregroundStyle(colors.primaryText)

                Text(w.condition)
                    .font(.headline)
                    .foregroundStyle(colors.accent)

            } else if viewModel.isLoading {
                ProgressView()
                    .tint(.cyan)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity)
    }
}
