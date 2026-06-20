//
//  APIConstants.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

struct APIConstants {
    static let baseURL = "https://api.weatherapi.com/v1"
    static var apiKey = Bundle.main.infoDictionary?["WEATHER_API_KEY"] as? String

}
