//
//  WeatherSummarySection.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import SwiftUI

struct WeatherSummaryCard: View {

    let hour: HourlyForecastModel

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            Text("CURRENT CONDITIONS")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)

            HStack(alignment: .bottom) {

                Text("\(Int(hour.temperature))°")
                    .font(.system(size: 72, weight: .bold))

                Spacer()
            }

            Text(hour.condition)
                .font(.title3)

            Text("Rain Chance \(hour.rainChance)%")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.ultraThinMaterial)
        .clipShape(
            RoundedRectangle(cornerRadius: 24)
        )
    }
}
