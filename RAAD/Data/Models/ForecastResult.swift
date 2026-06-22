//
//  ForecastResult.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation

struct ForecastResult {

    let dailyForecast: [ForecastModel]

    /// Hourly forecasts grouped by day — index 0 = day 0, index 1 = day 1, etc.
    let hourlyForecastByDay: [[HourlyForecastModel]]
}
