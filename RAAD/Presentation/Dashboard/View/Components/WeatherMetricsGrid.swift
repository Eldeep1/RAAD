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

    @EnvironmentObject var viewModel: DashboardViewModel
      var body: some View {

          LazyVGrid(columns: columns, spacing: 12) {

              WeatherMetricCard(
                             title: "Humidity",
                             value: "\(viewModel.weather?.humidity ?? 0)%",
                             subtitle: humidityDescription
                         )

              WeatherMetricCard(
                  title: "Pressure",
                  value: "\(Int(viewModel.weather?.pressure ?? 1013)) hPa",
                  subtitle: pressureDescription
              )

              WeatherMetricCard(
                  title: "Visibility",
                  value: "\(Int(viewModel.weather?.visibility ?? 0)) km",
                  subtitle: visibilityDescription
              )

              WeatherMetricCard(
                  title: "Feels Like",
                  value: "\(Int(viewModel.weather?.feelsLike ?? 0))°",
                  subtitle: feelsLikeDescription
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
private extension WeatherMetricsGrid {
    
    var weather: WeatherModel? {
        viewModel.weather
    }
    
    var humidityDescription: String {
        guard let humidity = weather?.humidity else { return "No Data" }
        switch humidity {
        case 0...30:   return "Dry"
        case 31...60:  return "Comfortable"
        default:       return "Humid"
        }
    }

    var pressureDescription: String {
        guard let pressure = weather?.pressure else { return "No Data" }
        
        if pressure < 1000 { return "Low" }
        if pressure > 1020 { return "High" }
        return "Stable"
    }

    var visibilityDescription: String {
        guard let visibility = weather?.visibility else { return "No Data" }
        
        return visibility >= 10 ? "Clear Horizon" : "Reduced Visibility"
    }

    var feelsLikeDescription: String {
        guard let w = weather else { return "No Data" }
        
        let diff = Int(w.feelsLike - w.temperature)
        
        if diff == 0 {
            return "No Difference"
        }
        
        let sign = diff > 0 ? "+" : ""
        return "\(sign)\(diff)° Difference"
    }
}
