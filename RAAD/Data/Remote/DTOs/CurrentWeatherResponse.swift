//
//  CurrentWeatherResponse.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    let location: LocationDTO
    let current: CurrentDTO
}
struct LocationDTO: Codable {
    
    let name: String
    let country: String
    let localtime: String
}
struct CurrentDTO: Codable {
    
    let temp_c: Double
    let humidity: Int
    let pressure_mb: Double
    
    let vis_km: Double
    let feelslike_c: Double

    let condition: ConditionDTO
}
