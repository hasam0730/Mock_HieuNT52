//
//  ReminderMovies+CoreDataProperties.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/5/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import CoreData


extension ReminderMovies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ReminderMovies> {
        return NSFetchRequest<ReminderMovies>(entityName: "ReminderMovies");
    }

    @NSManaged public var vote_count: Float
    @NSManaged public var vote_average: Float
    @NSManaged public var video: Bool
    @NSManaged public var title: String?
    @NSManaged public var status: String?
    @NSManaged public var release_date: String?
    @NSManaged public var poster_path: String?
    @NSManaged public var popularity: Double
    @NSManaged public var overview: String?
    @NSManaged public var original_title: String?
    @NSManaged public var original_language: String?
    @NSManaged public var id: Int64
    @NSManaged public var backdrop_path: String?
    @NSManaged public var adult: Bool
    @NSManaged public var time_reminder: Int64

}
