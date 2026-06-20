//
//  ContentView.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @StateObject private var themeManager = ThemeManager()
    var body: some View {
        DashboardView().environmentObject(themeManager)
    }
}
