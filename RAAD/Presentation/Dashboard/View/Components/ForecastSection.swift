//
//  ForecastSection.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

struct ForecastSection: View {
    var body: some View {
        
        VStack(spacing: 12) {

            ForecastCardView(
                day: "Tomorrow",
                temperature: "38°",
                condition: "Cloudy",
                icon: "cloud.fill"
            )

            ForecastCardView(
                day: "Wednesday",
                temperature: "35°",
                condition: "Heavy Rain",
                icon: "cloud.rain.fill"
            )

            ForecastCardView(
                day: "Thursday",
                temperature: "40°",
                condition: "Clear",
                icon: "sun.max.fill"
            )
        }
    }
}


struct ForecastCardView: View {

    let day: String
    let temperature: String
    let condition: String
    let icon: String

    var body: some View {

        HStack {

            VStack(alignment: .leading, spacing: 4) {

                Text(day)
                    .font(.caption)

                Text(condition)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Image(systemName: icon)
                .foregroundStyle(.cyan)

            Text(temperature)
                .fontWeight(.semibold)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 14)
                .fill(Color.white.opacity(0.08))
        )
    }
}
