//
//  DashboardViewModel.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

@MainActor
final class DashboardViewModel: ObservableObject {
    
    @Published var weather: WeatherModel?
    @Published var forecast:[ForecastModel] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    private let locationService: LocationServiceProtocol
    
    private let repository: WeatherRepositoryProtocol
    
    init(repository: WeatherRepositoryProtocol,locationService: LocationServiceProtocol) {
        self.repository = repository
        self.locationService = locationService
    }
    
    func loadWeather() async {
        
        isLoading = true
        do {
            let location = try await locationService.requestCurrentLocation()

            weather = try await repository.getCurrentWeather(
                longitude: location.coordinate.longitude,
                lattitude: location.coordinate.latitude
            )
            forecast = try await repository.getForecast(
                longitude: location.coordinate.longitude,
                lattitude: location.coordinate.latitude
            )
        }
        catch {
            errorMessage = error.localizedDescription
            print("the error we got is: \(errorMessage ?? "interestig")")
        }
        isLoading = false
    }
}
