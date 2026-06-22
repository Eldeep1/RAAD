//
//  DIContainer.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation

//
//
//
//let viewModel : DashboardViewModel
//init() {

//
//    self.viewModel =
class DIContainer {
    static let shared = DIContainer()
    private init() {}
    
    private func resolveNetworkManager() -> NetworkManagerProtocol {
        NetworkManager()
    }
       
    private func resolveRemoteDataSource() -> WeatherRemoteDataSourceProtocol {
        WeatherRemoteDataSource(networkManager: resolveNetworkManager())
    }
           
    private func resolveWeatherRepository() -> WeatherRepositoryProtocol {
        WeatherRepository(remoteDataSource: resolveRemoteDataSource())
    }
               
    private func resolveLocationService() -> LocationServiceProtocol {
        LocationService()
    }
    
    
    @MainActor func resolveDashboardViewModel() -> DashboardViewModel{
        DashboardViewModel(repository:resolveWeatherRepository(), locationService: resolveLocationService())
    }

//    func resolveWeatherDetailsViewModel(location: CLLocationCoordinate2D,selectedDate: Date) -> WeatherDetailsViewModel {
//        WeatherDetailsViewModel(
//            repository: resolveWeatherRepository(),
//            location: location,
//            selectedDate: selectedDate
//        )
//    }
}
