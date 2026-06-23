//
//  DIContainer.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation
import CoreData

class DIContainer {
    static let shared = DIContainer()
    private init() {}

    // MARK: - Networking

    private func resolveNetworkManager() -> NetworkManagerProtocol {
        NetworkManager()
    }

    private func resolveRemoteDataSource() -> WeatherRemoteDataSourceProtocol {
        WeatherRemoteDataSource(networkManager: resolveNetworkManager())
    }

    // MARK: - Repositories

    private func resolveWeatherRepository() -> WeatherRepositoryProtocol {
        WeatherRepository(remoteDataSource: resolveRemoteDataSource())
    }

    private func resolveLocationService() -> LocationServiceProtocol {
        LocationService()
    }

    func resolveFavouriteLocationRepository() -> FavouriteLocationRepository {
        FavouriteLocationRepository(context: PersistenceController.shared.container.viewContext)
    }

    // MARK: - ViewModels

    @MainActor func resolveDashboardViewModel() -> DashboardViewModel {
        DashboardViewModel(
            repository: resolveWeatherRepository(),
            locationService: resolveLocationService()
        )
    }

    @MainActor func resolveSearchViewModel() -> SearchViewModel {
        SearchViewModel(
            repository: resolveWeatherRepository(),
            favouriteRepo: resolveFavouriteLocationRepository()
        )
    }

    @MainActor func resolveCityWeatherViewModel(
        cityName: String,
        country: String,
        latitude: Double,
        longitude: Double
    ) -> CityWeatherViewModel {
        CityWeatherViewModel(
            cityName: cityName,
            country: country,
            latitude: latitude,
            longitude: longitude,
            repository: resolveWeatherRepository(),
            favouriteRepo: resolveFavouriteLocationRepository()
        )
    }
}
