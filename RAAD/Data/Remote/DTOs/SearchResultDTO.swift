//
//  SearchResultDTO.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation

struct SearchResultDTO: Codable, Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let lat: Double
    let lon: Double
}
