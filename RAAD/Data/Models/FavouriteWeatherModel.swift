//
//  FavouriteWeatherModel.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation

struct FavouriteWeatherModel: Identifiable {
    let id: UUID
    let cityName: String
    let country: String
    let latitude: Double
    let longitude: Double
    let temperature: Double
    let highTemp: Double
    let lowTemp: Double
    let condition: String
    let localTime: String
}
