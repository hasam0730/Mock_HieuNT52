//
//  SearchFavoriteMovieView.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/11/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import UIKit
let cellID = "cellid"
protocol SearchFavMovieDelegate: class {
    func pushtoDetailView(IdMovie:Int)
}
class SearchFavoriteMovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var moviesList = [FavoriteMovies]()
    var searchController : UISearchController!
    let tableView = UITableView()
    var filteredMovies = [FavoriteMovies]() // danh sách phim được filtered
    weak var delegate:SearchFavMovieDelegate? = nil
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Type something here ..."
        searchBar.tintColor = UIColor.white
        searchBar.barTintColor = headerColor
        searchBar.backgroundColor = headerColor
        searchBar.backgroundImage = UIImage()
        searchBar.backgroundColor = headerColor
        
        //*-------------custom textField inside SearchBar
        let textFieldInsideSearchBar = searchBar.value(forKey: "searchField") as? UITextField
        textFieldInsideSearchBar?.backgroundColor = textFieldSearchBar
        textFieldInsideSearchBar?.textColor = UIColor.white
        let textFieldInsideSearchBarLabel = textFieldInsideSearchBar!.value(forKey: "placeholderLabel") as? UILabel
        textFieldInsideSearchBarLabel?.textColor = UIColor.white
        
        //*-------------custom clear button
        let clearButton = textFieldInsideSearchBar?.value(forKey: "clearButton") as! UIButton
        clearButton.setImage(clearButton.imageView?.image?.withRenderingMode(.alwaysTemplate), for: .normal)
        clearButton.tintColor = UIColor.white
        
        //*--------------custom magnifier glass
        let glassIconView = textFieldInsideSearchBar?.leftView as? UIImageView
        glassIconView?.image = glassIconView?.image?.withRenderingMode(.alwaysTemplate)
        glassIconView?.tintColor = UIColor.white
        return searchBar
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        moviesList = fetchingReminderMovies()
        //
        setStatusBarBackgroundColor(color: headerColor)
        setupViews()
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func fetchingReminderMovies() -> [FavoriteMovies] {
        let array = CoreDataHandler.shareInstance.allRecords(FavoriteMovies.self)
        return array
    }
    
    fileprivate func setupViews() {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        tableView.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64)
        tableView.register(RowSearchFavMovie.self, forCellReuseIdentifier: cellID)
        tableView.tableFooterView = UIView()
        setupNavigationBar()
    }
    
    func setupNavigationBar() {
        // *setup navigation*
        let navigationItem = UINavigationItem()
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height:44)) // Offset by 20 pixels vertically to take the status bar into account
        navigationItem.title = "Favorite Movies"
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = headerColor
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(image: #imageLiteral(resourceName: "Back").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(back))
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        navigationItem.titleView = searchBar
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        //
        self.view.addSubview(navigationBar)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! RowSearchFavMovie
        cell.movie = filteredMovies[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    fileprivate func filterContentForSearchText(_ searchText : String) {
        self.filteredMovies = self.moviesList.filter({ (movie: FavoriteMovies) -> Bool in
            return (movie.title?.folding(options: .diacriticInsensitive, locale: NSLocale.current).lowercased().contains(searchText.folding(options: .diacriticInsensitive, locale: .current).lowercased()))! // remove diacritics from string. then lowercase string, check containt
        })
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let detailView = DetailMovieViewController()
        detailView.idMovie = Int(self.moviesList[indexPath.row].id)
        self.dismiss(animated: true, completion: { [weak self] in
            guard let strSelf = self else { return }
            if let delegate = self?.delegate {
                delegate.pushtoDetailView(IdMovie: Int(strSelf.filteredMovies[indexPath.row].id))
            }
        })
    }
}

extension SearchFavoriteMovieViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filterContentForSearchText(searchText)
    }
}

    
    
//    var searchController : UISearchController = {
//        let searchController = UISearchController(searchResultsController:  nil)
//        searchController.searchBar.showsCancelButton = false
//        searchController.searchBar.sizeToFit()
//        searchController.searchBar.frame = CGRect(x: 0, y: 0, width: 200, height: 20)
//        searchController.hidesNavigationBarDuringPresentation = false
//        searchController.dimsBackgroundDuringPresentation = true
//        return searchController
//    }() // searchController
//    
//    var searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20)) // uisearchBar
//    
//    var moviesList = [FavoriteMovies]() // danh sách all fav movies
//    
//    let noRecordLabel: UILabel = {
//        let label = UILabel()
//        label.attributedText = NSAttributedString(string: "No Record", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray])
//        label.textAlignment = .center
//        return label
//    }() // no record label
//    
//    var filteredMovies = [FavoriteMovies]() // danh sách phim được filtered
//    
//    let tableView = UITableView() // define tableView
//    
//    override func viewDidLoad() {
////        tableView.tableHeaderView = searchController.searchBar
//        super.viewDidLoad()
//        //
//        setupViews()
//        /* Setup delegates */
//        searchBar.delegate = self
//        tableView.delegate = self
//        tableView.dataSource = self
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        moviesList = fetchingFavoriteMovies()
//        tableView.reloadData()
//    }
//    
//    fileprivate func setupViews() {
//        hideKeyboardWhenTappedAround()
//        // *setup navigationBar*
//        setupNavigationBar()
//        //
//        tableView.register(CellForRowTableView.self, forCellReuseIdentifier: cellID)
//        setStatusBarBackgroundColor(color: headerColor)
//        self.view.addSubview(tableView)
//        tableView.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64)
//        tableView.tableFooterView = UIView()
//        tableView.backgroundColor = #colorLiteral(red: 0.1215686277, green: 0.01176470611, blue: 0.4235294163, alpha: 1)
//    }
//    
//    func setupNavigationBar() {
//        // *setup navigation*
//        let navigationItem = UINavigationItem()
//        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: UIScreen.main.bounds.width, height:44)) // Offset by 20 pixels vertically to take the status bar into account
//        navigationItem.title = "Reminder Movies"
//        navigationBar.isTranslucent = false
//        navigationBar.barTintColor = headerColor
//        // Create left and right button for navigation item
//        let leftButton =  UIBarButtonItem(image: #imageLiteral(resourceName: "Back").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(back))
//        // Create two buttons for the navigation item
//        navigationItem.leftBarButtonItem = leftButton
//        navigationItem.titleView = searchBar
//        searchBar.placeholder = "Type some words here ..."
//        // Assign the navigation item to the navigation bar
//        navigationBar.items = [navigationItem]
//        //
//        self.view.addSubview(navigationBar)
//    }
//    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("asda")
//    }
//    
//    func back() {
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    func fetchingFavoriteMovies() -> [FavoriteMovies] {
//        let array = CoreDataHandler.shareInstance.allRecords(FavoriteMovies.self)
//        return array
//    }
//    
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.moviesList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! CellForRowTableView
//        cell.movie = moviesList[indexPath.item]
//        return cell
//    }
//    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return CGFloat(150)
//    }
//    
//    fileprivate func filterContentForSearchText(_ searchText : String) {
//        self.filteredMovies = self.moviesList.filter({ (movie: FavoriteMovies) -> Bool in
//            return (movie.title?.folding(options: .diacriticInsensitive, locale: NSLocale.current).lowercased().contains(searchText.folding(options: .diacriticInsensitive, locale: .current).lowercased()))! // remove diacritics from string. then lowercase string, check containt
//        })
//        tableView.reloadData()
//    }
//}
//
//
//
//
////extension SearchFavoriteMovieViewController: UITableViewDelegate {
////
////}
//
//extension SearchFavoriteMovieViewController: UISearchBarDelegate {
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        filterContentForSearchText(searchText)
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        
//    }
//}




