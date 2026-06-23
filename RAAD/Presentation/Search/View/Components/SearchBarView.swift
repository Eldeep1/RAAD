//
//  SearchBarView.swift
//  RAAD
//
//  Created by depo on 23/06/2026.
//

import SwiftUI

struct SearchBarView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @Binding var query: String

    var body: some View {
        let colors = themeManager.currentTheme.colors

        HStack(spacing: 12) {
            Image(systemName: "magnifyingglass")
                .foregroundStyle(colors.accent)

            TextField("Search for a city...", text: $query)
                .foregroundStyle(colors.primaryText)
                .autocorrectionDisabled()
                .textInputAutocapitalization(.never)

            if !query.isEmpty {
                Button {
                    query = ""
                } label: {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(colors.secondaryText)
                }
            }
        }
        .padding(14)
        .background(colors.cardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

