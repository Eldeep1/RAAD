//
//  CurrentWeatherView.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @EnvironmentObject var viewModel: DashboardViewModel
    var body: some View {
        let colors = themeManager.currentTheme.colors

            VStack(spacing: 8) {

                Text(String(viewModel.weather?.city ?? ""))
                    .font(.caption)
                    .foregroundStyle(colors.primaryText)

                if !viewModel.forecast.isEmpty {
                    Text(String(viewModel.forecast[0].date ))
                        .font(.caption2)
                        .foregroundStyle(colors.accent)
                }

                Image(systemName: "cloud.sun.fill")
                    .font(.title2)
                    .foregroundStyle(.cyan)

                Text(
                    "\(Int(viewModel.weather?.temperature ?? 0))°"
                ).font(.system(size: 54, weight: .bold)).foregroundStyle(colors.primaryText)

                Text(
                    viewModel.weather?.condition
                    ?? ""
                ).font(.headline)
                    .foregroundStyle(colors.accent)
            }
            .frame(maxWidth: .infinity)
        }
}
