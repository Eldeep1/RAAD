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
    let networkManager : NetworkManagerProtocol
    
    let remoteDataSource : WeatherRemoteDataSourceProtocol
    
    let repository : WeatherRepositoryProtocol
    
    let viewModel : DashboardViewModel
    init() {
        let manager = NetworkManager()
        self.networkManager = manager
        self.remoteDataSource = WeatherRemoteDataSource(networkManager: manager)
        self.repository = WeatherRepository(remoteDataSource: remoteDataSource)
        self.viewModel = DashboardViewModel(repository:repository)
    }
    var body: some View {
        DashboardView(viewModel: viewModel).environmentObject(themeManager)
    }
}
