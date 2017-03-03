//
//  Constant.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation

// 1
let urlMovieListPopular = "https://api.themoviedb.org/3/movie/popular?api_key=e7631ffcb8e766993e5ec0c1f4245f93&page="
// 2
let prefixUrlMovieDetail = "https://api.themoviedb.org/3/movie/"
let suffixUrlMovieDetail = "?api_key=e7631ffcb8e766993e5ec0c1f4245f93"
// 3
let prefixUrlCastAndCrewList = "https://api.themoviedb.org/3/movie/"
let suffixUrlCastAndCrewList = "/credits?api_key=e7631ffcb8e766993e5ec0c1f4245f93"
// 4
let urlImage = "https://image.tmdb.org/t/p/"
// 5
var statusDisplayListMovie: typeDisplayListMovie = .list
let RELOAD_NOTIFICATION = NSNotification.Name("ReloadCollectionViewMovie")
// 6
let headerColor = UIColor.rgb(red: 213, green: 46, blue: 90)
let rateTextColor = UIColor.rgb(red: 54, green: 206, blue: 235)
let titleColor = UIColor.rgb(red: 211, green: 52, blue: 55)
let backgroundColor = UIColor.rgb(red: 87, green: 115, blue: 178)
// 7
var typeIphone: sizeIPhone = sizeIPhone.IPhoneSE
