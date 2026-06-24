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
            
            NavigationView {
                DashboardView(viewModel: DIContainer.shared.resolveDashboardViewModel())
                    .environmentObject(themeManager)
            }
            .tabItem {
                Label("Home", systemImage: "house.fill")
            }

            
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

        appearance.backgroundColor = UIColor(colors.cardBackground)

        appearance.stackedLayoutAppearance.selected.iconColor  = UIColor(colors.accent)
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [
            .foregroundColor: UIColor(colors.accent)
        ]

        let unselected = UIColor.systemGray
        appearance.stackedLayoutAppearance.normal.iconColor = unselected
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [
            .foregroundColor: unselected
        ]

        UITabBar.appearance().standardAppearance   = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
}
