//
//  SearchResultsSection.swift
//  RAAD
//
//  Created by depo on 23/06/2026.
//

import SwiftUI
struct SearchResultsSection: View {
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        let colors = themeManager.currentTheme.colors

        VStack(alignment: .leading, spacing: 12) {

            if viewModel.isSearching {
                HStack {
                    Spacer()
                    ProgressView().tint(.cyan)
                    Spacer()
                }
                .padding()
            } else if viewModel.searchResults.isEmpty {
                Text("No results found")
                    .font(.subheadline)
                    .foregroundStyle(colors.secondaryText)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding()
            } else {
                ForEach(viewModel.searchResults) { result in
                    NavigationLink {
                        CityWeatherView(
                            viewModel: DIContainer.shared.resolveCityWeatherViewModel(
                                cityName: result.name,
                                country: result.country,
                                latitude: result.latitude,
                                longitude: result.longitude
                            )
                        )
                        .environmentObject(themeManager)
                    } label: {
                        SearchResultRow(result: result)
                    }
                    .simultaneousGesture(TapGesture().onEnded {
                        viewModel.commitSearch(result.name)
                    })
                }
            }
        }
    }
}
private struct SearchResultRow: View {
    @EnvironmentObject var themeManager: ThemeManager
    let result: SearchResultModel

    var body: some View {
        let colors = themeManager.currentTheme.colors

        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(result.name)
                    .font(.headline)
                    .foregroundStyle(colors.primaryText)
                Text("\(result.region), \(result.country)")
                    .font(.caption)
                    .foregroundStyle(colors.secondaryText)
            }
            Spacer()
            Image(systemName: "location.fill")
                .foregroundStyle(colors.accent)
        }
        .padding()
        .background(colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
