//
//  SearchResultModel.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation

struct SearchResultModel: Identifiable {
    let id: Int
    let name: String
    let region: String
    let country: String
    let latitude: Double
    let longitude: Double
}
