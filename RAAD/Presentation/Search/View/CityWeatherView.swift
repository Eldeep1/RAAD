//
//  CityWeatherView.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import SwiftUI

struct CityWeatherView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel: CityWeatherViewModel

    var body: some View {
        let colors = themeManager.currentTheme.colors

        ScrollView {
            VStack(spacing: 20) {

                CityCurrentWeatherView()
                    .environmentObject(viewModel)

                CityForecastSection()
                    .environmentObject(viewModel)

                if let w = viewModel.weather {
                    CityMetricsGridInline(weather: w)
                }
            }
            .padding()
        }
        .background(colors.background)
        .foregroundStyle(colors.primaryText)
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.toggleFavourite()
                } label: {
                    Image(systemName: viewModel.isFavourite ? "heart.fill" : "heart")
                        .foregroundStyle(.cyan)
                        .imageScale(.large)
                        .animation(.spring(duration: 0.3), value: viewModel.isFavourite)
                }
            }
        }
        .task { await viewModel.loadWeather() }
    }
}
