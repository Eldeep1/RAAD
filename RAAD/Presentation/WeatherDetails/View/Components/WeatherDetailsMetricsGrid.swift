//
//  WeatherDetailsMetricsGrid.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import SwiftUI

struct WeatherDetailsMetricsGrid: View {

    let hour: HourlyForecastModel

    private let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {

        LazyVGrid(
            columns: columns,
            spacing: 16
        ) {

            MetricCard(
                title: "Humidity",
                value: "\(hour.humidity)%",
                icon: "humidity"
            )

            MetricCard(
                title: "Wind",
                value: "\(Int(hour.windSpeed)) km/h",
                icon: "wind"
            )

            MetricCard(
                title: "Pressure",
                value: "\(Int(hour.pressure)) hPa",
                icon: "gauge"
            )

            MetricCard(
                title: "Rain",
                value: "\(hour.rainChance)%",
                icon: "cloud.rain"
            )
        }
    }
}
struct MetricCard: View {

    let title: String

    let value: String

    let icon: String

    var body: some View {

        VStack(alignment: .leading, spacing: 12) {

            Image(systemName: icon)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
        }
        .frame(
            maxWidth: .infinity,
            minHeight: 120,
            alignment: .leading
        )
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
    }
}
