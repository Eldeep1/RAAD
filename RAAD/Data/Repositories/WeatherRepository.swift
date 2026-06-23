//
//  WeatherRepository.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

protocol WeatherRepositoryProtocol {
    
    func getCurrentWeather(longitude:Double, lattitude:Double) async throws -> WeatherModel
    
    func getForecast(longitude:Double, lattitude:Double) async throws -> ForecastResult
    
    func searchCities(query: String) async throws -> [SearchResultModel]
    
    func getFavouriteWeather(latitude: Double, longitude: Double) async throws -> FavouriteWeatherModel
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
    
    func getForecast(longitude:Double, lattitude:Double) async throws -> ForecastResult {
        
        let dto = try await remoteDataSource.getForecast(
                longitude: longitude,
                lattitude: lattitude,
                days: 3
            )

            let daily = dto.forecast.forecastday.map {
                ForecastModel(
                    date: $0.date,
                    temperature: $0.day.avgtemp_c,
                    condition: $0.day.condition.text
                )
            }

            let hourlyByDay = dto.forecast.forecastday.map { day in
                day.hour.map {
                    HourlyForecastModel(
                        time: $0.time,
                        temperature: $0.temp_c,
                        humidity: $0.humidity,
                        pressure: $0.pressure_mb,
                        windSpeed: $0.wind_kph,
                        rainChance: $0.chance_of_rain,
                        condition: $0.condition.text
                    )
                }
            }

            return ForecastResult(dailyForecast: daily, hourlyForecastByDay: hourlyByDay)
        }
    
    func searchCities(query: String) async throws -> [SearchResultModel] {
        let dtos = try await remoteDataSource.searchCities(query: query)
        return dtos.map {
            SearchResultModel(
                id: $0.id,
                name: $0.name,
                region: $0.region,
                country: $0.country,
                latitude: $0.lat,
                longitude: $0.lon
            )
        }
    }
    
    func getFavouriteWeather(latitude: Double, longitude: Double) async throws -> FavouriteWeatherModel {
        async let currentTask  = remoteDataSource.getCurrentWeather(longitude: longitude, lattitude: latitude)
        async let forecastTask = remoteDataSource.getForecast(longitude: longitude, lattitude: latitude, days: 1)

        let (current, forecast) = try await (currentTask, forecastTask)

        let today = forecast.forecast.forecastday.first

        // Parse localtime "yyyy-MM-dd HH:mm" → "HH:mm • TZ"
        let localTimeString = WeatherRepository.formatLocalTime(
            localtime: forecast.location.localtime,
            tzId: forecast.location.tz_id
        )

        return FavouriteWeatherModel(
            id: UUID(),
            cityName: forecast.location.name,
            country: forecast.location.country,
            latitude: latitude,
            longitude: longitude,
            temperature: current.current.temp_c,
            highTemp: today?.day.maxtemp_c ?? current.current.temp_c,
            lowTemp: today?.day.mintemp_c ?? current.current.temp_c,
            condition: current.current.condition.text,
            localTime: localTimeString
        )
    }

    // MARK: - Helpers

    private static func formatLocalTime(localtime: String, tzId: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"

        guard let date = formatter.date(from: localtime) else { return localtime }

        let output = DateFormatter()
        output.dateFormat = "HH:mm"

        // Derive a short timezone abbreviation from the tz_id e.g. "Europe/London" → "BST"
        let tz = TimeZone(identifier: tzId) ?? .current
        output.timeZone = tz
        let timeStr = output.string(from: date)

        let abbr = tz.abbreviation(for: date) ?? tzId
        return "\(timeStr) • \(abbr)"
    }
}
