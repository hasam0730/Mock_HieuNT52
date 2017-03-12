//
//  DataHandler.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation

class DataHandler {
    //
    static let shared = DataHandler()
    // get data from url string
    func gettingDataFromUrl(urlString: String, completion: @escaping (_ data: NSDictionary)->Void) {
        let url = URL(string: "\(urlString)")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) -> Void in
            if let myError = error {
                print(myError.localizedDescription)
            }
            else if let jsonObject = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as? NSDictionary {
                completion(jsonObject!)
            }
        }).resume()
    }
    
    // get popular movie from data
    func gettingMovieFrom(urlString: String, pageNumber: Int? = 1, completion: @escaping (_ data: [Movie]) -> Void) {
        var listMovies = [Movie]()
        let urlStr = "\(urlString)\(pageNumber!)"
        gettingDataFromUrl(urlString: urlStr, completion: {(data: NSDictionary) in
            let arrMovieDictionary: [AnyObject] = data.value(forKey: "results") as! [AnyObject]
            for item in arrMovieDictionary {
                var newMovie = Movie()
                newMovie.poster_path = item.value(forKey: kParseJSon.poster_path.rawValue) as? String ?? ""
                newMovie.adult = item.value(forKey: kParseJSon.adult.rawValue) as? Bool ?? false
                newMovie.overview = item.value(forKey: kParseJSon.overview.rawValue) as? String  ?? ""
                newMovie.release_date = item.value(forKey: kParseJSon.release_date.rawValue) as? String ?? ""
                newMovie.genre_ids = item.value(forKey: kParseJSon.genre_ids.rawValue) as? [Int] ?? []
                newMovie.id = item.value(forKey: kParseJSon.id.rawValue) as? Int ?? 0
                newMovie.original_title = item.value(forKey: kParseJSon.original_title.rawValue) as? String ?? ""
                newMovie.title = item.value(forKey: kParseJSon.title.rawValue) as? String ?? ""
                newMovie.backdrop_path = item.value(forKey: kParseJSon.backdrop_path.rawValue) as? String ?? ""
                newMovie.popularity = item.value(forKey: kParseJSon.popularity.rawValue) as? Double ?? 0.0
                newMovie.vote_count = item.value(forKey: kParseJSon.vote_count.rawValue) as? Float ?? 0
                newMovie.video = item.value(forKey: kParseJSon.video.rawValue) as? Bool ?? false
                newMovie.vote_average = item.value(forKey: kParseJSon.vote_average.rawValue) as? Float ?? 0
                //
                listMovies.append(newMovie)
            }
            completion(listMovies)
        })
    }
    
    // getting top rated movie from data
    func searchingMovieWith(urlPath: String? = urlSearchMovie, nameMovie: String, completion: @escaping (_ data: [Movie]) ->Void) {
        var listMovies = [Movie]()
        let urlStr = "\(urlPath!)\(nameMovie)"
        gettingDataFromUrl(urlString: urlStr, completion: {(data: NSDictionary) in
            let arrMoviesDic: [AnyObject] = data.value(forKey: "results") as! [AnyObject]
            for item in arrMoviesDic {
                var newMovie = Movie()
                newMovie.poster_path = item.value(forKey: kParseJSon.poster_path.rawValue) as? String ?? ""
                newMovie.adult = item.value(forKey: kParseJSon.adult.rawValue) as? Bool ?? false
                newMovie.overview = item.value(forKey: kParseJSon.overview.rawValue) as? String  ?? ""
                newMovie.release_date = item.value(forKey: kParseJSon.release_date.rawValue) as? String ?? ""
                newMovie.genre_ids = item.value(forKey: kParseJSon.genre_ids.rawValue) as? [Int] ?? []
                newMovie.id = item.value(forKey: kParseJSon.id.rawValue) as? Int ?? 0
                newMovie.original_title = item.value(forKey: kParseJSon.original_title.rawValue) as? String ?? ""
                newMovie.title = item.value(forKey: kParseJSon.title.rawValue) as? String ?? ""
                newMovie.backdrop_path = item.value(forKey: kParseJSon.backdrop_path.rawValue) as? String ?? ""
                newMovie.popularity = item.value(forKey: kParseJSon.popularity.rawValue) as? Double ?? 0.0
                newMovie.vote_count = item.value(forKey: kParseJSon.vote_count.rawValue) as? Float ?? 0
                newMovie.video = item.value(forKey: kParseJSon.video.rawValue) as? Bool ?? false
                newMovie.vote_average = item.value(forKey: kParseJSon.vote_average.rawValue) as? Float ?? 0
                //
                listMovies.append(newMovie)
            }
            completion(listMovies)
        })
    }
    
    // get data detail movie by idmovie
    func gettingMovieDetailByIdMovie(idMovie: Int, completion: @escaping (_ data: Movie) ->Void) {
        var movie = Movie()
        let url = "\(prefixUrlMovieDetail)\(idMovie)\(suffixUrlMovieDetail)"
        gettingDataFromUrl(urlString: url, completion: {(data: NSDictionary) in
            movie.poster_path = data.value(forKey: kParseJSon.poster_path.rawValue) as? String ?? ""
            movie.adult = data.value(forKey: kParseJSon.adult.rawValue) as? Bool ?? false
            movie.overview = data.value(forKey: kParseJSon.overview.rawValue) as? String ?? ""
            movie.release_date = data.value(forKey: kParseJSon.release_date.rawValue) as? String ?? ""
            movie.id = data.value(forKey: kParseJSon.id.rawValue) as? Int ?? 0
            movie.original_title = data.value(forKey: kParseJSon.original_title.rawValue) as? String ?? ""
            movie.original_language = data.value(forKey: kParseJSon.original_language.rawValue) as? String ?? ""
            movie.title = data.value(forKey: kParseJSon.title.rawValue) as? String ?? ""
            movie.backdrop_path = data.value(forKey: kParseJSon.poster_path.rawValue) as? String ?? ""
            movie.popularity = data.value(forKey: kParseJSon.popularity.rawValue) as? Double ?? 0
            movie.vote_count = data.value(forKey: kParseJSon.vote_count.rawValue) as? Float ?? 0
            movie.vote_average = data.value(forKey: kParseJSon.vote_average.rawValue) as? Float ?? 0.0
            //
            completion(movie)
        })
    }
    
    // get data detail movie by idmovie
    func gettingCastList(idMovie: Int, completion: @escaping (_ data: [Cast]) -> Void) {
        var listCasts = [Cast]()
        let url = "\(prefixUrlCastAndCrewList)\(idMovie)\(suffixUrlCastAndCrewList)"
        gettingDataFromUrl(urlString: url, completion: {(data: NSDictionary) in
            let arrActDictionary: [AnyObject] = data.value(forKey: "cast") as! [AnyObject]
            for item in arrActDictionary {
                var newCast = Cast()
                //
                newCast.cast_id = item[kCast.cast_id.rawValue] as? Int ?? 0
                newCast.character = item[kCast.character.rawValue] as? String ?? ""
                newCast.credit_id = item[kCast.credit_id.rawValue] as? String ?? ""
                newCast.id = item[kCast.id.rawValue] as? Int ?? 0
                newCast.name = item[kCast.name.rawValue] as? String ?? ""
                newCast.order = item[kCast.order.rawValue] as? Int ?? 0
                newCast.profile_path = item[kCast.profile_path.rawValue] as? String ?? ""
                //
                listCasts.append(newCast)
            }
            completion(listCasts)
        })
    }
}
