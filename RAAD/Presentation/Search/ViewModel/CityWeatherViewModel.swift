//
//  CityWeatherViewModel.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation

@MainActor
final class CityWeatherViewModel: ObservableObject {

    @Published var weather: WeatherModel?
    @Published var forecast: [ForecastModel] = []
    @Published var hourlyForecastByDay: [[HourlyForecastModel]] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var isFavourite: Bool = false


    let cityName: String
    let country: String
    let latitude: Double
    let longitude: Double


    private let repository: WeatherRepositoryProtocol
    private let favouriteRepo: FavouriteLocationRepository


    init(
        cityName: String,
        country: String,
        latitude: Double,
        longitude: Double,
        repository: WeatherRepositoryProtocol,
        favouriteRepo: FavouriteLocationRepository
    ) {
        self.cityName      = cityName
        self.country       = country
        self.latitude      = latitude
        self.longitude     = longitude
        self.repository    = repository
        self.favouriteRepo = favouriteRepo
        self.isFavourite   = favouriteRepo.isFavourite(cityName: cityName)
    }

    func loadWeather() async {
        isLoading = true
        do {
            async let weatherTask  = repository.getCurrentWeather(longitude: longitude, lattitude: latitude)
            async let forecastTask = repository.getForecast(longitude: longitude, lattitude: latitude)

            let (w, f) = try await (weatherTask, forecastTask)
            weather = w
            forecast = f.dailyForecast
            hourlyForecastByDay = f.hourlyForecastByDay
        } catch {
            errorMessage = error.localizedDescription
        }
        isLoading = false
    }


    func toggleFavourite() {
        if isFavourite {
            favouriteRepo.remove(cityName: cityName)
        } else {
            favouriteRepo.add(
                cityName: cityName,
                country: country,
                latitude: latitude,
                longitude: longitude
            )
        }
        isFavourite.toggle()
    }
}
