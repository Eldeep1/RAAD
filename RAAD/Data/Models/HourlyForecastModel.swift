//
//  HourlyForecastModel.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation
struct HourlyForecastModel: Identifiable {

    let id = UUID()

    let time: String

    let temperature: Double

    let humidity: Int

    let pressure: Double

    let windSpeed: Double

    let rainChance: Int

    let condition: String
}

extension HourlyForecastModel {

    var displayTime: String {

        let input = DateFormatter()
        input.dateFormat = "yyyy-MM-dd HH:mm"

        guard let date = input.date(from: time)
        else {
            return time
        }

        let output = DateFormatter()
        output.dateFormat = "HH:mm"

        return output.string(from: date)
    }
}
