//
//  ForecastResponse.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

struct ForecastResponse: Codable {
    let location: ForecastLocationDTO
    let forecast: ForecastDTO
}

struct ForecastLocationDTO: Codable {
    let name: String
    let country: String
    let localtime: String
    let tz_id: String
}

struct ForecastDTO: Codable {
    let forecastday: [ForecastDayDTO]
}

struct ForecastDayDTO: Codable {
    let date: String
    let day: DayDTO
    let hour: [HourDTO]
}

struct DayDTO: Codable {
    let avgtemp_c: Double
    let maxtemp_c: Double
    let mintemp_c: Double
    let condition: ConditionDTO
}

struct ConditionDTO: Codable {
    let text: String
    let icon: String
}
