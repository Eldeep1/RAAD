//
//  WeatherRemoteDataSource.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

protocol WeatherRemoteDataSourceProtocol {
    
    func getCurrentWeather( city: String) async throws -> CurrentWeatherResponse
    
    func getForecast(city: String, days: Int) async throws -> ForecastResponse
}

final class WeatherRemoteDataSource: WeatherRemoteDataSourceProtocol {
    
    private let networkManager:NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }
    
    func getCurrentWeather(city: String) async throws -> CurrentWeatherResponse {
        try await networkManager.request(
            endpoint: .current(city: city)
        )
    }
    
    func getForecast(city: String, days: Int) async throws -> ForecastResponse {
        
        try await networkManager.request(
            endpoint: .forecast(
                city: city,
                days: days
            )
        )
    }
}
