//
//  DashboardView.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var themeManager: ThemeManager

    var body: some View {
        let colors = themeManager.currentTheme.colors
        
        ScrollView {
            
            VStack(spacing: 20) {
                
                HeaderView()
                
                CurrentWeatherView()
                
                ForecastSection()
                
                WeatherMetricsGrid()
                
            }
            .padding()
        }.background(colors.background).foregroundStyle(colors.primaryText)
    }
}
    
