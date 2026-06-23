//
//  SavedLocationsSection.swift
//  RAAD
//
//  Created by depo on 23/06/2026.
//

import SwiftUI
struct SavedLocationsSection: View {
    @EnvironmentObject var themeManager: ThemeManager
    @ObservedObject var viewModel: SearchViewModel
    @State private var isEditMode: Bool = false

    var body: some View {
        let colors = themeManager.currentTheme.colors

        VStack(alignment: .leading, spacing: 16) {

            // Header row
            HStack {
                Text("Saved Locations")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundStyle(colors.primaryText)

                Spacer()

                if !viewModel.favourites.isEmpty {
                    Button {
                        withAnimation { isEditMode.toggle() }
                    } label: {
                        HStack(spacing: 4) {
                            Text(isEditMode ? "DONE" : "EDIT")
                                .font(.caption)
                                .fontWeight(.bold)
                            if !isEditMode {
                                Image(systemName: "pencil")
                                    .font(.caption)
                            }
                        }
                        .foregroundStyle(colors.accent)
                    }
                }
            }

            // Empty state
            if viewModel.isLoadingFavourites {
                HStack {
                    Spacer()
                    ProgressView().tint(.cyan)
                    Spacer()
                }
                .padding(.vertical, 40)

            } else if viewModel.favourites.isEmpty {
                VStack(spacing: 12) {
                    Image(systemName: "heart.slash")
                        .font(.largeTitle)
                        .foregroundStyle(colors.secondaryText)
                    Text("No favourites yet")
                        .font(.subheadline)
                        .foregroundStyle(colors.secondaryText)
                    Text("Search for a city and tap ♡ to save it here.")
                        .font(.caption)
                        .foregroundStyle(colors.secondaryText)
                        .multilineTextAlignment(.center)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)

            } else {
                ForEach(viewModel.favourites) { fav in
                    FavouriteCardView(
                        favourite: fav,
                        isEditMode: isEditMode,
                        onDelete: { viewModel.removeFavourite(cityName: fav.cityName) }
                    )
                }
            }
        }
    }
}

struct FavouriteCardView: View {
    @EnvironmentObject var themeManager: ThemeManager
    let favourite: FavouriteWeatherModel
    let isEditMode: Bool
    let onDelete: () -> Void

    @State private var showDeleteConfirmation = false

    var body: some View {
        let colors = themeManager.currentTheme.colors

        NavigationLink {
            CityWeatherView(
                viewModel: DIContainer.shared.resolveCityWeatherViewModel(
                    cityName: favourite.cityName,
                    country: favourite.country,
                    latitude: favourite.latitude,
                    longitude: favourite.longitude
                )
            )
            .environmentObject(themeManager)
        } label: {
            HStack(alignment: .center) {

                // Left — name / time / condition
                VStack(alignment: .leading, spacing: 6) {
                    Text(favourite.cityName)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundStyle(colors.primaryText)

                    Text(favourite.localTime)
                        .font(.caption)
                        .foregroundStyle(colors.secondaryText)

                    HStack(spacing: 4) {
                        Image(systemName: conditionIcon(favourite.condition))
                            .font(.caption)
                            .foregroundStyle(colors.accent)
                        Text(favourite.condition.uppercased())
                            .font(.caption2)
                            .fontWeight(.semibold)
                            .foregroundStyle(colors.accent)
                    }
                }

                Spacer()

                // Right — temperature + H/L
                VStack(alignment: .trailing, spacing: 4) {
                    Text("\(Int(favourite.temperature))°")
                        .font(.system(size: 44, weight: .light))
                        .foregroundStyle(colors.primaryText)

                    Text("H: \(Int(favourite.highTemp))° L: \(Int(favourite.lowTemp))°")
                        .font(.caption)
                        .foregroundStyle(colors.secondaryText)
                }

                // Delete button in edit mode
                if isEditMode {
                    Button {
                        showDeleteConfirmation = true
                    } label: {
                        Image(systemName: "minus.circle.fill")
                            .foregroundStyle(.red)
                            .font(.title3)
                            .padding(.leading, 8)
                    }
                    .transition(.scale.combined(with: .opacity))
                }
            }
            .padding()
            .background(colors.cardBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
        .buttonStyle(.plain)
        .alert("Remove \(favourite.cityName)?", isPresented: $showDeleteConfirmation) {
            Button("Remove", role: .destructive) {
                withAnimation { onDelete() }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("\(favourite.cityName) will be removed from your saved locations.")
        }
    }

    private func conditionIcon(_ condition: String) -> String {
        let c = condition.lowercased()
        if c.contains("rain")   { return "cloud.rain.fill" }
        if c.contains("storm")  { return "cloud.bolt.rain.fill" }
        if c.contains("sun") || c.contains("clear") { return "sun.max.fill" }
        if c.contains("cloud")  { return "cloud.fill" }
        if c.contains("snow")   { return "snowflake" }
        return "cloud.fill"
    }
}
