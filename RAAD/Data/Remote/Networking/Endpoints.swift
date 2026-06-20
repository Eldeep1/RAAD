//
//  Endpoints.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

enum Endpoint {
    
    case current(city: String)
    case forecast(city: String, days: Int)
    
    var path: String {
        
        switch self {
        case .current:
            return "/current.json"
            
        case .forecast:
            return "/forecast.json"
        }
    }
    
    var queryItems: [URLQueryItem] {
        
        switch self {
            
        case .current(let city):
            
            return [
                .init(name: "key", value: APIConstants.apiKey),
                .init(name: "q", value: city)
            ]
            
        case .forecast(let city, let days):
            
            return [
                .init(name: "key", value: APIConstants.apiKey),
                .init(name: "q", value: city),
                .init(name: "days", value: "\(days)")
            ]
        }
    }
}
