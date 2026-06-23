//
//  SearchView.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import SwiftUI

struct SearchView: View {
    @EnvironmentObject var themeManager: ThemeManager
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        let colors = themeManager.currentTheme.colors
        
        NavigationView {
            ZStack {
                colors.background.ignoresSafeArea()
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        SearchBarView(query: $viewModel.query)
                            .onChange(of: viewModel.query) { _ in
                                viewModel.onQueryChanged()}
                        
                        if !viewModel.query.trimmingCharacters(in: .whitespaces).isEmpty {
                            SearchResultsSection(viewModel: viewModel)
                        } else {
                            if !viewModel.recentSearches.isEmpty {
                                RecentChipsRow(recents: viewModel.recentSearches) { term in
                                    viewModel.query = term
                                    viewModel.onQueryChanged()
                                }
                            }
                            SavedLocationsSection(viewModel: viewModel)
                        }
                    }
                    .padding()
                }
            }
            .foregroundStyle(colors.primaryText)
            .navigationBarHidden(true)
            .onAppear { viewModel.loadFavourites() }
        }
    }
}
