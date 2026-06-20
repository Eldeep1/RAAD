//
//  ThemeManager.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation

final class ThemeManager: ObservableObject {

    @Published var currentTheme: AppTheme = .morning

    init() {
        updateTheme()
    }

    func updateTheme() {

        let hour = Calendar.current.component(.hour, from: Date())

        currentTheme = hour >= 18
            ? .evening
            : .morning
    }
}
