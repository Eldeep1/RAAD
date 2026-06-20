//
//  WeatherRepository.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

protocol WeatherRepositoryProtocol {
    
    func getCurrentWeather(longitude:Double, lattitude:Double) async throws -> WeatherModel
    
    func getForecast(longitude:Double, lattitude:Double) async throws -> [ForecastModel]
}

final class WeatherRepository:WeatherRepositoryProtocol {
    
    private let remoteDataSource: WeatherRemoteDataSourceProtocol
    
    init(remoteDataSource:WeatherRemoteDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getCurrentWeather(longitude:Double, lattitude:Double) async throws -> WeatherModel {
        
        let dto = try await remoteDataSource.getCurrentWeather(
            longitude: longitude,
            lattitude: lattitude
        )
        return WeatherModel(
            city: dto.location.name,
            country: dto.location.country,
            temperature: dto.current.temp_c,
            condition: dto.current.condition.text,
            humidity: dto.current.humidity,
            pressure: dto.current.pressure_mb,
            visibility: dto.current.vis_km,
            feelsLike: dto.current.feelslike_c
        )
    }
    
    func getForecast(longitude:Double, lattitude:Double) async throws -> [ForecastModel] {
        
        let dto = try await remoteDataSource.getForecast(
            longitude: longitude,
            lattitude: lattitude,
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
