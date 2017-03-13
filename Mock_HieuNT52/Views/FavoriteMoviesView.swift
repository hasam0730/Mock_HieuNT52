//
//  File.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

let cellId = "cellId"
class FavoriteMoviesController: UITableViewController {
    var moviesList = [FavoriteMovies]() // danh sách all fav movies
    var searchController : UISearchController! // searchController
    let noRecordLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "No Record", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray])
        label.textAlignment = .center
        return label
    }() // no record label
    var filteredMovies = [FavoriteMovies]() // danh sách phim được filtered
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Favorite Movies"
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        self.setupRremainingNavItems()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesList = fetchingFavoriteMovies()
        tableView.reloadData()
    }
    
    fileprivate func setupViews() {
        tableView.register(CellForRowTableView.self, forCellReuseIdentifier: cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.rowHeight = 1000
        //
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.searchResultsUpdater = self
        self.searchController.searchBar.showsCancelButton = false
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.definesPresentationContext = true
        //
        let leftButton =  UIBarButtonItem(image: #imageLiteral(resourceName: "Search").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(showSearchView))
        // Create two buttons for the navigation item
        navigationItem.rightBarButtonItem = leftButton
        navigationItem.backBarButtonItem =  UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    func showSearchView() {
        let searchFavMovie = SearchFavoriteMovieViewController()
        searchFavMovie.delegate = self
        self.present(searchFavMovie, animated: true)
    }
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CellForRowTableView
        cell.movie = moviesList[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Warrning", message: "Are you sure that you want to delete this movie", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { action in
                let idmv:Int64 = Int64(self.moviesList[indexPath.row].id)
                self.deletingMovie(idmv: idmv)
                self.moviesList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { action in
                
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let detailView = DetailMovieViewController()
        detailView.idMovie = Int(self.moviesList[indexPath.row].id)
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    fileprivate func filterContentForSearchText(_ searchText : String) {
        self.filteredMovies = self.moviesList.filter({ (movie: FavoriteMovies) -> Bool in
            return (movie.title?.folding(options: .diacriticInsensitive, locale: NSLocale.current).lowercased().contains(searchText.folding(options: .diacriticInsensitive, locale: .current).lowercased()))! // remove diacritics from string. then lowercase string, check containt
        })
        tableView.reloadData()
    }
}

extension FavoriteMoviesController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        self.present(SearchFavoriteMovieViewController(), animated: true)
    }
}

extension FavoriteMoviesController: SearchFavMovieDelegate {
    func pushtoDetailView(IdMovie:Int) {
        let detailView = DetailMovieViewController()
        detailView.idMovie = IdMovie
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}


