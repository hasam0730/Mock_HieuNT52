//
//  Constant.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import UIKit
// 1
let urlMovieListPopular = "https://api.themoviedb.org/3/movie/popular?api_key=e7631ffcb8e766993e5ec0c1f4245f93&page="
let urlMovieListTopRated = "https://api.themoviedb.org/3/movie/top_rated?api_key=e7631ffcb8e766993e5ec0c1f4245f93&page="
let urlMovieListUpComing = "https://api.themoviedb.org/3/movie/upcoming?api_key=e7631ffcb8e766993e5ec0c1f4245f93&page="
let urlMovieListNowPlaying = "https://api.themoviedb.org/3/movie/now_playing?api_key=e7631ffcb8e766993e5ec0c1f4245f93&page="
let urlSearchMovie = "https://api.themoviedb.org/3/search/movie?api_key=e7631ffcb8e766993e5ec0c1f4245f93&query="
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
let FILTER_NOTIFICATION = NSNotification.Name("FilterNotification")
let DISABLE_REMINDER_NOTIFICATION = NSNotification.Name("Disablereminder")
let TOPRATED_NOTIFICATION = NSNotification.Name("LoadingtopratedMovie")
let UPCOMING_NOTIFICATION = NSNotification.Name("LoadingUpcomingMovie")
let NOWPLAYING_NOTIFICATION = NSNotification.Name("LoadingNewPlayingMovie")
// 6
let headerColor = UIColor.rgb(red: 85, green: 60, blue: 92)
let bgViewColor = UIColor.rgb(red: 58, green: 62, blue: 71)
let borderColor = UIColor.rgb(red: 159, green: 99, blue: 28)
let bgCellColor = UIColor.rgb(red: 58, green: 62, blue: 71)
let rateTextColor = UIColor.rgb(red: 54, green: 206, blue: 235)
let titleColor = UIColor.rgb(red: 211, green: 52, blue: 55)
let backgroundColor = UIColor.rgb(red: 87, green: 115, blue: 178)
let startPointColor = UIColor.rgb(red: 19, green: 207, blue: 191)
let endPointColor = UIColor.rgb(red: 24, green: 219, blue: 161)
let startColor = UIColor.rgb(red: 33, green: 29, blue: 49)
let endColor = UIColor.rgb(red: 75, green: 64, blue: 46)
let textFieldSearchBar = UIColor.rgb(red: 105, green: 80, blue: 112)
// 7

var typeIphone: sizeIPhone = sizeIPhone.IPhoneSE
