//
//  DetailMovieController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/3/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import CoreData
extension DetailMovieViewController {
    func addingFavorite(movie: Movie) {
        let idmv: Int64 = Int64(movie.id!)
        if !isExistFavMovie(idMovie: idmv) {
            let popularity: Double = Double(movie.popularity!)
            //------------them record
            let record = CoreDataHandler.shareInstance.addRecord(FavoriteMovies.self)
            record.poster_path          = movie.poster_path
            record.adult                = movie.adult!
            record.overview             = movie.overview
            record.release_date         = movie.release_date
            record.id                   = idmv
            record.original_title       = movie.original_title
            record.original_language    = movie.original_language
            record.title                = movie.title
            record.backdrop_path        = movie.backdrop_path
            record.popularity           = Double(popularity)
            record.vote_count           = movie.vote_count!
            record.vote_average         = movie.vote_average!
            record.status               = movie.status
            record.release_date         = movie.release_date
            let result = CoreDataHandler.shareInstance.saveContext()
            if result {
                print("luu thanh cong")
            } else {
                print("luu that bai")
            }
        }
        
        
//------------xoa record theo object
//        let curitem = CoreDataHandler.shareInstance.query(FavoriteMovies.self, search: NSPredicate(format: "id == %ld", idmv)) // return array
//        CoreDataHandler.shareInstance.deleteRecord(curitem[0])
//        _ = CoreDataHandler.shareInstance.saveContext()

//------------xoa record theo predicate
//        _ = CoreDataHandler.shareInstance.deleteRecords(FavoriteMovies.self, search: NSPredicate(format: "title == %@", "Rings"))
//        _ = CoreDataHandler.shareInstance.saveContext()

//------------dem so record trong table
//        let count = CoreDataHandler.shareInstance.recordsInTable(FavoriteMovies.self)
//        print(count)
        
//------------lay tat ca records trong table
//        let array = CoreDataHandler.shareInstance.allRecords(FavoriteMovies.self)
//        print(array.count)
        
    }
    
    func isExistFavMovie(idMovie: Int64) -> Bool {
        let movie = CoreDataHandler.shareInstance.query(FavoriteMovies.self, search: NSPredicate(format: "id == %ld", idMovie))
        if let _ = movie.first {
            return true
        }
        return false
    }
    
    func addingReminder(movie: Movie, time_reminder: Int) {
        let idmv: Int64 = Int64(movie.id!)
        let timeReminder: Int64 = Int64(time_reminder)
        let popularity: Double = Double(movie.popularity!)
        let record = CoreDataHandler.shareInstance.addRecord(ReminderMovies.self)
        record.poster_path          = movie.poster_path
        record.adult                = movie.adult!
        record.overview             = movie.overview
        record.release_date         = movie.release_date
        record.id                   = idmv
        record.original_title       = movie.original_title
        record.original_language    = movie.original_language
        record.title                = movie.title
        record.backdrop_path        = movie.backdrop_path
        record.popularity           = Double(popularity)
        record.vote_count           = movie.vote_count!
        record.vote_average         = movie.vote_average!
        record.status               = movie.status
        record.release_date         = movie.release_date
        record.time_reminder        = timeReminder
        let result = CoreDataHandler.shareInstance.saveContext()
        if result {
            print("luu thanh cong")
        } else {
            print("luu that bai")
        }
    }
}
