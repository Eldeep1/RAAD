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
    
    
    private let repository: WeatherRepositoryProtocol
    
    init(repository: WeatherRepositoryProtocol) {
        self.repository = repository
    }
    
    func loadWeather() async {
        isLoading = true
        do {
            weather = try await repository.getCurrentWeather(
                city: "Dubai"
            )
            forecast = try await repository.getForecast(
                city: "Dubai"
            )
        }
        catch {
            errorMessage = error.localizedDescription
            print("the error we got is: \(errorMessage ?? "interestig")")
        }
        isLoading = false
    }
}
