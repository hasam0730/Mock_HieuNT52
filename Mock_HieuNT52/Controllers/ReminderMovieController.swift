//
//  ReminderMovieController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/6/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import UIKit

extension ReminderMovieController {
    func fetchingReminderMovies() -> [ReminderMovies] {
        let array = CoreDataHandler.shareInstance.allRecords(ReminderMovies.self)
        return array
    }
    
    func deletingMovie(idmv: Int64) {
        _ = CoreDataHandler.shareInstance.deleteRecords(ReminderMovies.self, search: NSPredicate(format: "id == %d", idmv))
        _ = CoreDataHandler.shareInstance.saveContext()
    }
}
