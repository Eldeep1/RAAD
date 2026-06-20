//
//  CurrentWeatherView.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

struct CurrentWeatherView: View {
    @EnvironmentObject var themeManager: ThemeManager
    var body: some View {
        let colors = themeManager.currentTheme.colors

            VStack(spacing: 8) {

                Text("Dubai")
                    .font(.caption)
                    .foregroundStyle(colors.primaryText)

                Text("Monday, 14 July")
                    .font(.caption2)
                    .foregroundStyle(colors.accent)

                Image(systemName: "cloud.sun.fill")
                    .font(.title2)
                    .foregroundStyle(.cyan)

                Text("42°")
                    .font(.system(size: 54, weight: .bold)).foregroundStyle(colors.primaryText)

                Text("STORMY")
                    .font(.headline)
                    .foregroundStyle(colors.accent)
            }
            .frame(maxWidth: .infinity)
        }
}
