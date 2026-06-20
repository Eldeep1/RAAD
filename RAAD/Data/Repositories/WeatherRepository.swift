//
//  WeatherRepository.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

protocol WeatherRepositoryProtocol {
    
    func getCurrentWeather(city: String) async throws -> WeatherModel
    
    func getForecast(city: String) async throws -> [ForecastModel]
}

final class WeatherRepository:WeatherRepositoryProtocol {
    
    private let remoteDataSource: WeatherRemoteDataSourceProtocol
    
    init(remoteDataSource:WeatherRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getCurrentWeather(city: String) async throws -> WeatherModel {
        
        let dto = try await remoteDataSource.getCurrentWeather(
            city: city
        )
        return WeatherModel(
            city: dto.location.name,
            country: dto.location.country,
            temperature: dto.current.temp_c,
            condition: dto.current.condition.text,
            humidity: dto.current.humidity,
            pressure: dto.current.pressure_mb
        )
    }
    
    func getForecast(city: String) async throws -> [ForecastModel] {
        
        let dto = try await remoteDataSource.getForecast(
                city: city,
                days: 3
            )
        
        return dto.forecast.forecastday.map {
            
            ForecastModel(
                date: $0.date,
                temperature: $0.day.avgtemp_c,
                condition: $0.day.condition.text
            )
        }
    }
}
