//
//  FavouriteLocationRepository.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation
import CoreData

final class FavouriteLocationRepository {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    // MARK: - Read

    func fetchAll() -> [FavouriteLocation] {
        let request = NSFetchRequest<FavouriteLocation>(entityName: "FavouriteLocation")
        request.sortDescriptors = [NSSortDescriptor(key: "addedAt", ascending: false)]
        return (try? context.fetch(request)) ?? []
    }

    func isFavourite(cityName: String) -> Bool {
        let request = NSFetchRequest<FavouriteLocation>(entityName: "FavouriteLocation")
        request.predicate = NSPredicate(format: "cityName ==[c] %@", cityName)
        return (try? context.count(for: request)) ?? 0 > 0
    }

    // MARK: - Write

    func add(cityName: String, country: String, latitude: Double, longitude: Double) {
        let entity = FavouriteLocation(context: context)
        entity.cityName   = cityName
        entity.country    = country
        entity.latitude   = latitude
        entity.longitude  = longitude
        entity.addedAt    = Date()
        saveContext()
    }

    func remove(cityName: String) {
        let request = NSFetchRequest<FavouriteLocation>(entityName: "FavouriteLocation")
        request.predicate = NSPredicate(format: "cityName ==[c] %@", cityName)
        guard let objects = try? context.fetch(request) else { return }
        objects.forEach { context.delete($0) }
        saveContext()
    }

    // MARK: - Helpers

    private func saveContext() {
        guard context.hasChanges else { return }
        try? context.save()
    }
}
