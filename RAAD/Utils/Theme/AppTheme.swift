//
//  AppTheme.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation
enum AppTheme {
    case morning
    case evening
    
    var colors: ThemeColors {
        switch self {
        case .morning: return .morning
        case .evening: return .evening
        }
    }
}
