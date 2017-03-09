//
//  ReminderMovieViewController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/6/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import UIKit

class ReminderMovieController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var moviesList = [ReminderMovies]()
    var searchController : UISearchController!
    let tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()
        let navigationBar = UINavigationBar(frame: CGRect(x: 0, y: 20, width: view.frame.size.width, height:44)) // Offset by 20 pixels vertically to take the status bar into account
        // Create a navigation item with a title
        let navigationItem = UINavigationItem()
        navigationItem.title = "Reminder Movies"
        navigationBar.isTranslucent = false
        navigationBar.barTintColor = headerColor
        // Create left and right button for navigation item
        let leftButton =  UIBarButtonItem(image: #imageLiteral(resourceName: "Back"), style: .done, target: self, action: #selector(back))
        // Create two buttons for the navigation item
        navigationItem.leftBarButtonItem = leftButton
        // Assign the navigation item to the navigation bar
        navigationBar.items = [navigationItem]
        setStatusBarBackgroundColor(color: headerColor)
        // Make the navigation bar a subview of the current view controller
        self.view.addSubview(navigationBar)
        setupViews()
    }
    
    func back() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesList = fetchingReminderMovies()
//        tableView.reloadData()
    }
    
    fileprivate func setupViews() {
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height - 64)
        tableView.register(CellForRowReminderMovie.self, forCellReuseIdentifier: cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.rowHeight = 1000
        //
        self.searchController = UISearchController(searchResultsController:  nil)
        
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self

        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true

        self.navigationItem.titleView = searchController.searchBar

        self.definesPresentationContext = true
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CellForRowReminderMovie
        cell.movie = moviesList[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(150)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let alert = UIAlertController(title: "Warrning", message: "Are you sure that you want to delete this movie", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.default) { action in
                self.moviesList.remove(at: indexPath.row)
                let idmv:Int64 = Int64(self.moviesList[indexPath.row].id)
                self.deletingMovie(idmv: idmv)
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { action in
                
            }
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let detailView = DetailMovieViewController()
        detailView.idMovie = Int(self.moviesList[indexPath.row].id)
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

extension ReminderMovieController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
//        strScope = searchBar.scopeButtonTitles![selectedScope].lowercased()
//        filterContentForSearchText(searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.selectedScopeButtonIndex = 0
//        strScope = "all"
//        myTableView.reloadData()
    }
}

extension ReminderMovieController: UISearchControllerDelegate {
    
}

extension ReminderMovieController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        let searchBar = searchController.searchBar
//        let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
//        //        ["All", "Chocolate", "Hard", "Other"]
//        filterContentForSearchText(searchBar.text!, scope: scope)
//        
    }
}
