//
//  FavouriteLocation+CoreDataClass.swift
//  RAAD
//
//  Created by depo on 22/06/2026.
//

import Foundation
import CoreData

@objc(FavouriteLocation)
public class FavouriteLocation: NSManagedObject {

    @NSManaged public var cityName: String
    @NSManaged public var country: String
    @NSManaged public var latitude: Double
    @NSManaged public var longitude: Double
    @NSManaged public var addedAt: Date
}

extension FavouriteLocation: Identifiable {}
