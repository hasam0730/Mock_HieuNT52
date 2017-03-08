//
//  ReminderMovieViewController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/6/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import UIKit

class ReminderMovieController: UITableViewController {
    var moviesList = [ReminderMovies]()
    var searchController : UISearchController!
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Reminder Movies"
        view.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
        //        self.setupRightItem()
        //        self.setupLeftItem()
        self.setupRremainingNavItems()
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        moviesList = fetchingReminderMovies()
//        tableView.reloadData()
    }
    
    fileprivate func setupViews() {
        tableView.register(CellForRowReminderMovie.self, forCellReuseIdentifier: cellId)
        tableView.translatesAutoresizingMaskIntoConstraints = true
        tableView.rowHeight = 1000
        //
        self.searchController = UISearchController(searchResultsController:  nil)
        
        //        self.searchController.searchResultsUpdater = self
        //        self.searchController.delegate = self
        //        self.searchController.searchBar.delegate = self
        
//        self.searchController.hidesNavigationBarDuringPresentation = false
//        self.searchController.dimsBackgroundDuringPresentation = true
        
        //        self.navigationItem.titleView = searchController.searchBar
        
//        self.definesPresentationContext = true
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.moviesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CellForRowReminderMovie
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        let detailView = DetailMovieViewController()
        detailView.idMovie = Int(self.moviesList[indexPath.row].id)
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}
