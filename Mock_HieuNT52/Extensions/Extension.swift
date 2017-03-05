//
//  File.swift
//  exampleSwift
//
//  Created by Developer on 2/13/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import CoreData

extension UIColor {
    class func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views:UIView...) {
        var viewsDictionary = [String:UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil,
                                                      views: viewsDictionary))
    }
}

extension UIViewController {
    func showAlertController( titleOfAlert: String, messageOfAlert : String, actionSave : @escaping (()->Void), actionCancel : @escaping (()->Void) ) {
        let alert = UIAlertController(title: titleOfAlert, message: messageOfAlert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) { action in
            actionSave()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { action in
            actionCancel()
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func castingFavMovieToMovie(input: FavoriteMovies) -> Movie{
        var movie = Movie()
        movie.poster_path =  input.poster_path
        movie.adult = input.adult
        movie.id = Int(input.id)
        movie.original_title = input.original_title
        movie.original_language = input.original_language
        movie.title = input.title
        movie.backdrop_path = input.backdrop_path
        movie.popularity = Int(input.popularity)
        movie.vote_count = input.vote_count
        movie.vote_average = input.vote_average
        movie.status = input.status
        return movie
    }
}

extension NSManagedObject {
    class var entityName : String {
        let components = NSStringFromClass(self).components(separatedBy: ".")
        return components[1]
    }
}

extension NSManagedObjectContext {
    
    func insert<T: NSManagedObject>(entity: T.Type) -> T {
        let entityName = entity.entityName
        return NSEntityDescription.insertNewObject(forEntityName: entityName, into:self) as! T
    }
    
}


