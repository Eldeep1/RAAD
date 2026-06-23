//
//  SearchViewModel.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation
import Combine
import CoreData

@MainActor
final class SearchViewModel: ObservableObject {


    @Published var query: String = ""
    @Published var searchResults: [SearchResultModel] = []
    @Published var favourites: [FavouriteWeatherModel] = []
    @Published var recentSearches: [String] = []
    @Published var isSearching: Bool = false
    @Published var isLoadingFavourites: Bool = false
    @Published var errorMessage: String?


    private let repository: WeatherRepositoryProtocol
    private let favouriteRepo: FavouriteLocationRepository


    private var searchTask: Task<Void, Never>?
    private let recentKey = "recentSearches"


    init(repository: WeatherRepositoryProtocol, favouriteRepo: FavouriteLocationRepository) {
        self.repository = repository
        self.favouriteRepo = favouriteRepo
        loadRecentSearches()
    }


    func onQueryChanged() {
        searchTask?.cancel()

        let trimmed = query.trimmingCharacters(in: .whitespaces)
        guard trimmed.count >= 2 else {
            searchResults = []
            isSearching   = false
            return
        }

        isSearching = true
        searchTask = Task {
            // 400ms debounce
            try? await Task.sleep(nanoseconds: 400_000_000)
            guard !Task.isCancelled else { return }

            do {
                let results = try await repository.searchCities(query: trimmed)
                guard !Task.isCancelled else { return }
                searchResults = results
            } catch {
                guard !Task.isCancelled else { return }
                errorMessage = error.localizedDescription
            }
            isSearching = false
        }
    }

    func commitSearch(_ term: String) {
        saveRecentSearch(term)
    }

    func loadFavourites() {
        let saved = favouriteRepo.fetchAll()
        guard !saved.isEmpty else {
            favourites = []
            return
        }

        isLoadingFavourites = true
        Task {
            var result: [FavouriteWeatherModel] = []
            for loc in saved {
                if let model = try? await repository.getFavouriteWeather(
                    latitude: loc.latitude,
                    longitude: loc.longitude
                ) {
                    result.append(model)
                }
            }
            favourites = result
            isLoadingFavourites = false
        }
    }

    func removeFavourite(cityName: String) {
        favouriteRepo.remove(cityName: cityName)
        favourites.removeAll { $0.cityName.lowercased() == cityName.lowercased() }
    }

    private func loadRecentSearches() {
        recentSearches = UserDefaults.standard.stringArray(forKey: recentKey) ?? []
    }

    func saveRecentSearch(_ term: String) {
        var recents = recentSearches
        recents.removeAll { $0.lowercased() == term.lowercased() }
        recents.insert(term, at: 0)
        if recents.count > 5 { recents = Array(recents.prefix(5)) }
        recentSearches = recents
        UserDefaults.standard.set(recents, forKey: recentKey)
    }
}
