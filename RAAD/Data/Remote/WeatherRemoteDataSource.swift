//
//  WeatherRemoteDataSource.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

protocol WeatherRemoteDataSourceProtocol {
    func getCurrentWeather(longitude: Double, lattitude: Double) async throws -> CurrentWeatherResponse
    func getForecast(longitude: Double, lattitude: Double, days: Int) async throws -> ForecastResponse
    func searchCities(query: String) async throws -> [SearchResultDTO]
}

final class WeatherRemoteDataSource: WeatherRemoteDataSourceProtocol {

    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func getCurrentWeather(longitude: Double, lattitude: Double) async throws -> CurrentWeatherResponse {
        try await networkManager.request(
            endpoint: .current(latitude: lattitude, longitude: longitude)
        )
    }

    func getForecast(longitude: Double, lattitude: Double, days: Int) async throws -> ForecastResponse {
        try await networkManager.request(
            endpoint: .forecast(latitude: lattitude, longitude: longitude, days: days)
        )
    }

    func searchCities(query: String) async throws -> [SearchResultDTO] {
        try await networkManager.request(endpoint: .search(query: query))
    }
}

