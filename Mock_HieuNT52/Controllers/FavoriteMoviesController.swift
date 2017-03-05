//
//  FavoriteMoviesController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/4/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import CoreData

extension FavoriteMoviesController {
    func fetchingFavoriteMovies() -> [FavoriteMovies] {
        let array = CoreDataHandler.shareInstance.allRecords(FavoriteMovies.self)
        return array
    }
    
    func deletingMovie(idmv: Int64) {
        _ = CoreDataHandler.shareInstance.deleteRecords(FavoriteMovies.self, search: NSPredicate(format: "id == %d", idmv))
        _ = CoreDataHandler.shareInstance.saveContext()
    }
}
