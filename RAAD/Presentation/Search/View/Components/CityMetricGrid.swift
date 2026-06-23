//
//  CityMetricGrid.swift
//  RAAD
//
//  Created by depo on 23/06/2026.
//

import SwiftUI

struct CityMetricsGridInline: View {
    @EnvironmentObject var themeManager: ThemeManager
    let weather: WeatherModel
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        let colors = themeManager.currentTheme.colors
        
        LazyVGrid(columns: columns, spacing: 16) {
            MetricTile(icon: "humidity",label: "Humidity",value: "\(weather.humidity)%",colors: colors)
            MetricTile(icon: "gauge",label: "Pressure",value: "\(Int(weather.pressure)) hPa",colors: colors)
            MetricTile(icon: "eye",label: "Visibility", value: "\(Int(weather.visibility)) km",colors: colors)
            MetricTile(icon: "thermometer",label: "Feels Like", value: "\(Int(weather.feelsLike))°",colors: colors)
        }
    }
}

private struct MetricTile: View {
    let icon: String
    let label: String
    let value: String
    let colors: ThemeColors
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Image(systemName: icon)
                .foregroundStyle(colors.accent)
            
            Text(label)
                .font(.caption)
                .foregroundStyle(colors.secondaryText)
            
            Text(value)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundStyle(colors.primaryText)
        }
        .frame(maxWidth: .infinity, minHeight: 100, alignment: .leading)
        .padding()
        .background(colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}

