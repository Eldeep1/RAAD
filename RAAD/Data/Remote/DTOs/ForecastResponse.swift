//
//  ForecastResponse.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

struct ForecastResponse: Codable {
    let forecast: ForecastDTO
}
struct ForecastDTO: Codable {
    
    let forecastday: [ForecastDayDTO]
}

struct ForecastDayDTO: Codable {
    
    let date: String
    
    let day: DayDTO
}
struct DayDTO: Codable {
    
    let avgtemp_c: Double
    
    let condition: ConditionDTO
}
struct ConditionDTO: Codable {
    
    let text: String
    let icon: String
}
