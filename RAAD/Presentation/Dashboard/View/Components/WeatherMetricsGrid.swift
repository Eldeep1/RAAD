//
//  WeatherMetricsGrid.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

struct WeatherMetricsGrid: View {
    let columns = [
          GridItem(.flexible()),
          GridItem(.flexible())
      ]

      var body: some View {

          LazyVGrid(columns: columns, spacing: 12) {

              WeatherMetricCard(
                  title: "Humidity",
                  value: "12%",
                  subtitle: "Dry"
              )

              WeatherMetricCard(
                  title: "Pressure",
                  value: "1012 hPa",
                  subtitle: "Stable"
              )

              WeatherMetricCard(
                  title: "Visibility",
                  value: "10 km",
                  subtitle: "Clear Horizon"
              )

              WeatherMetricCard(
                  title: "Feels Like",
                  value: "45°",
                  subtitle: "+3° Difference"
              )
          }
      }
  }

struct WeatherMetricCard: View {

    let title: String
    let value: String
    let subtitle: String

    var body: some View {

        VStack(alignment: .leading, spacing: 8) {

            Text(title.uppercased())
                .font(.caption2)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title3)
                .fontWeight(.bold)

            Text(subtitle)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.08))
        )
    }
}
