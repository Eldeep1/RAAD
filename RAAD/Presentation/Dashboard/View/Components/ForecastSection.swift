//
//  ForecastSection.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

struct ForecastSection: View {
    @EnvironmentObject var viewModel: DashboardViewModel
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        
        VStack(spacing: 12) {

            ForEach(
                viewModel.forecast,
                id: \.date
            ) { forecast in
                NavigationLink {
                    WeatherDetailsView(hours: viewModel.hourlyForecast).environmentObject(themeManager)
                } label: {
                ForecastCardView(
                    day: forecast.date,
                    temperature: "\(Int(forecast.temperature))°",
                    condition: forecast.condition,
                    icon: "cloud.fill"
                )}
            }
        }
    }
}


struct ForecastCardView: View {

    let day: String
    let temperature: String
    let condition: String
    let icon: String

    var body: some View {

        HStack {

            VStack(alignment: .leading, spacing: 4) {

                Text(day)
                    .font(.caption)

                Text(condition)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: icon)
                .foregroundStyle(.cyan)

            Text(temperature)
                .fontWeight(.semibold)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.08))
        )
    }
}
