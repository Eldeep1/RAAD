//
//  LocationService.swift
//  RAAD
//
//  Created by depo on 20/06/2026.
//

import Foundation
import CoreLocation

protocol LocationServiceProtocol {
    func requestCurrentLocation() async throws -> CLLocation
}

final class LocationService: NSObject {

    private let manager = CLLocationManager()

    private var continuation:
        CheckedContinuation<CLLocation, Error>?
}

extension LocationService: LocationServiceProtocol {

    func requestCurrentLocation() async throws -> CLLocation {

        manager.delegate = self

        manager.requestWhenInUseAuthorization()

        manager.requestLocation()

        return try await withCheckedThrowingContinuation {
            continuation = $0
        }
    }
}
extension LocationService: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {

        guard let location = locations.first else {
            return
        }

        continuation?.resume(returning: location)
        continuation = nil
    }

    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {

        continuation?.resume(throwing: error)
        continuation = nil
    }
}
