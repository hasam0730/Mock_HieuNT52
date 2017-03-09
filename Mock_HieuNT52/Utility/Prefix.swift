//
//  Prefix.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/2/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation

enum sizeIPhone: String {
    case IPhoneSE
    case IPhone7
    case IPhone7Plus
}

enum kNameEntity: String {
    case FavoriteMovies
}

enum typeDisplayListMovie: String {
    case grid
    case list
}
//
enum kLogoSize: String {
    case w45
    case w92
    case w154
    case w185
    case w300
    case w500
    case original
}

enum kPosterSize: String {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

enum kProfileSize: String {
    case w45
    case w185
    case h632
    case original
}

enum kStillSize: String {
    case w92
    case w185
    case w300
    case original
}
//
enum kParseJSon: String {
    case poster_path
    case adult
    case overview
    case release_date
    case genre_ids
    case id
    case original_title
    case original_language
    case title
    case backdrop_path
    case popularity
    case vote_count
    case video
    case vote_average
}

enum kCast: String {
    case cast_id
    case character
    case credit_id
    case id
    case name
    case order
    case profile_path
}

enum kCrew: String {
    case credit_id
    case department
    case id
    case job
    case name
    case profile_path
}

enum kUser: String {
    case avatar
    case name
    case DOB
    case email
    case sex
}

enum kSetting: String {
    case settingRateMovie
    case settingReleaseYear
    case settingNumberLoadding
    case settingModeFilter
    case settingModeSort
}
