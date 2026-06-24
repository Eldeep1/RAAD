//
//  FavouriteLocationRepository.swift
//  RAAD
//
//  Created by depo on 24/06/2026.
//

import Foundation


protocol FavouriteLocationRepositoryProtocol {
    func fetchAll() -> [FavouriteLocationEntity]
    func add(cityName: String, country: String, latitude: Double, longitude: Double)
    func remove(cityName: String)
    func isFavourite(cityName: String) -> Bool
}


final class FavouriteLocationRepository: FavouriteLocationRepositoryProtocol {

    private let localDataSource: FavouriteLocalDataSourceProtocol

    init(localDataSource: FavouriteLocalDataSourceProtocol) {
        self.localDataSource = localDataSource
    }


    func fetchAll() -> [FavouriteLocationEntity] {
        localDataSource.fetchAll().map { managed in
            FavouriteLocationEntity(
                cityName:  managed.cityName,
                country:   managed.country,
                latitude:  managed.latitude,
                longitude: managed.longitude,
                addedAt:   managed.addedAt
            )
        }
    }

    func isFavourite(cityName: String) -> Bool {
        localDataSource.exists(cityName: cityName)
    }


    func add(cityName: String, country: String, latitude: Double, longitude: Double) {
        localDataSource.insert(
            cityName:  cityName,
            country:   country,
            latitude:  latitude,
            longitude: longitude,
            addedAt:   Date()
        )
    }

    func remove(cityName: String) {
        localDataSource.delete(cityName: cityName)
    }
}
