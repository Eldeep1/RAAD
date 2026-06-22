//
//  DashboardView.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

struct DashboardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject private var viewModel:DashboardViewModel
    
    init(viewModel:DashboardViewModel) {
        _viewModel = StateObject( wrappedValue:viewModel)
    }
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
        }.environmentObject(viewModel)
            .background(colors.background).foregroundStyle(colors.primaryText).task {
                await viewModel.loadWeather()
            }.navigationBarHidden(true)
    }
}

