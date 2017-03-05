//
//  FavoriteMovies+CoreDataProperties.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/4/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import CoreData


extension FavoriteMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoriteMovies> {
        return NSFetchRequest<FavoriteMovies>(entityName: "FavoriteMovies");
    }

    @NSManaged public var adult: Bool
    @NSManaged public var backdrop_path: String?
    @NSManaged public var id: Int64
    @NSManaged public var original_language: String?
    @NSManaged public var original_title: String?
    @NSManaged public var overview: String?
    @NSManaged public var popularity: Double
    @NSManaged public var poster_path: String?
    @NSManaged public var release_date: String?
    @NSManaged public var status: String?
    @NSManaged public var title: String?
    @NSManaged public var video: Bool
    @NSManaged public var vote_average: Float
    @NSManaged public var vote_count: Float

}
