//
//  FavouriteLocalDataSource.swift
//  RAAD
//
//  Created by depo on 24/06/2026.
//

import Foundation
import CoreData


protocol FavouriteLocalDataSourceProtocol {
    func fetchAll() -> [FavouriteLocation]
    func insert(cityName: String, country: String, latitude: Double, longitude: Double, addedAt: Date)
    func delete(cityName: String)
    func exists(cityName: String) -> Bool
}


final class FavouriteLocalDataSource: FavouriteLocalDataSourceProtocol {

    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }


    func fetchAll() -> [FavouriteLocation] {
        let request = NSFetchRequest<FavouriteLocation>(entityName: "FavouriteLocation")
        request.sortDescriptors = [NSSortDescriptor(key: "addedAt", ascending: false)]
        return (try? context.fetch(request)) ?? []
    }

    func exists(cityName: String) -> Bool {
        let request = NSFetchRequest<FavouriteLocation>(entityName: "FavouriteLocation")
        request.predicate = NSPredicate(format: "cityName ==[c] %@", cityName)
        return (try? context.count(for: request)) ?? 0 > 0
    }


    func insert(cityName: String, country: String, latitude: Double, longitude: Double, addedAt: Date) {
        let entity        = FavouriteLocation(context: context)
        entity.cityName   = cityName
        entity.country    = country
        entity.latitude   = latitude
        entity.longitude  = longitude
        entity.addedAt    = addedAt
        saveContext()
    }

    func delete(cityName: String) {
        let request = NSFetchRequest<FavouriteLocation>(entityName: "FavouriteLocation")
        request.predicate = NSPredicate(format: "cityName ==[c] %@", cityName)
        guard let objects = try? context.fetch(request) else { return }
        objects.forEach { context.delete($0) }
        saveContext()
    }


    private func saveContext() {
        guard context.hasChanges else { return }
        try? context.save()
    }
}
