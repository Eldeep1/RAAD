//
//  HourlyForecast.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation

struct HourDTO: Codable {

    let time: String

    let temp_c: Double

    let humidity: Int

    let wind_kph: Double

    let pressure_mb: Double

    let chance_of_rain: Int

    let condition: ConditionDTO
}
