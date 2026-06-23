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
        TabView {
            // ── Home tab ─────────────────────────────────────────────────
            NavigationView {
                DashboardView(viewModel: DIContainer.shared.resolveDashboardViewModel())
                    .environmentObject(themeManager)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            // ── Search / Favourites tab ───────────────────────────────────
            SearchView(viewModel: DIContainer.shared.resolveSearchViewModel())
                .environmentObject(themeManager)
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
        .onAppear { applyTabBarTheme() }
        .onChange(of: themeManager.currentTheme) { _ in applyTabBarTheme() }
    }

    private func applyTabBarTheme() {
        let colors = themeManager.currentTheme.colors
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()

        // Background matches the card background from the current theme
        appearance.backgroundColor = UIColor(colors.cardBackground)

        // Selected icon / label — accent (cyan)
        appearance.stackedLayoutAppearance.selected.iconColor  = UIColor(colors.accent)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(colors.accent)
        ]

        // Unselected — a neutral grey that reads clearly in both light & dark
        let unselected = UIColor.systemGray
        appearance.stackedLayoutAppearance.normal.iconColor = unselected
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: unselected
        ]

        UITabBar.appearance().standardAppearance   = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
