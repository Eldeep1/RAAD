//
//  ThemeColors.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation
import SwiftUI

struct ThemeColors {

    let background: Color
    let cardBackground: Color

    let primaryText: Color
    let secondaryText: Color

    let accent: Color

}

extension ThemeColors {

    static let morning = ThemeColors(
        background: .white,
        cardBackground: Color(.systemGray6),
        primaryText: .black,
        secondaryText: .gray,
        accent: .cyan
    )

    static let evening = ThemeColors(
        background: Color(red: 0.04, green: 0.06, blue: 0.1),
        cardBackground: Color.white.opacity(0.08),
        primaryText: .white,
        secondaryText: .gray,
        accent: .cyan
    )
}
