//
// WeatherDetailsViewModel.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

@MainActor
final class WeatherDetailsViewModel: ObservableObject {

    @Published var hours: [HourlyForecastModel]

    @Published var selectedHour: HourlyForecastModel?

    init(hours: [HourlyForecastModel]) {
        self.hours = hours
        self.selectedHour = hours.first
    }

    func selectHour(_ hour: HourlyForecastModel) {
        selectedHour = hour
    }
}
