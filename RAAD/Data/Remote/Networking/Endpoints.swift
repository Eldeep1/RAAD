//
//  Endpoints.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

enum Endpoint {
    
    case current(latitude: Double, longitude: Double)
    case forecast(latitude: Double, longitude: Double, days: Int)
    case search(query: String)

    var path: String {
        switch self {
        case .current:   return "/current.json"
        case .forecast:  return "/forecast.json"
        case .search:    return "/search.json"
        }
    }

    var queryItems: [URLQueryItem] {
        switch self {

        case .current(let latitude, let longitude):
            return [
                .init(name: "key", value: APIConstants.apiKey),
                .init(name: "q",   value: "\(latitude),\(longitude)")
            ]

        case .forecast(let latitude, let longitude, let days):
            return [
                .init(name: "key",  value: APIConstants.apiKey),
                .init(name: "q",    value: "\(latitude),\(longitude)"),
                .init(name: "days", value: "\(days)")
            ]

        case .search(let query):
            return [
                .init(name: "key", value: APIConstants.apiKey),
                .init(name: "q",   value: query)
            ]
        }
    }
}
