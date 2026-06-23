//
//  RecentChipsRow.swift
//  RAAD
//
//  Created by depo on 23/06/2026.
//

import SwiftUI

struct RecentChipsRow: View {
    @EnvironmentObject var themeManager: ThemeManager
    let recents: [String]
    let onTap: (String) -> Void

    var body: some View {
        let colors = themeManager.currentTheme.colors

        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 8) {
                Text("RECENT:")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(colors.secondaryText)

                ForEach(recents, id: \.self) { term in
                    Button {
                        onTap(term)
                    } label: {
                        Text(term.uppercased())
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundStyle(colors.primaryText)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(colors.cardBackground)
                            .clipShape(Capsule())
                    }
                }
            }
        }
    }
}
