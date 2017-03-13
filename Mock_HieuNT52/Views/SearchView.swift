//
//  SearchViewController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/10/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation

class SearchViewController: UITableViewController {
    let cellId = "cellId"
    var searchController : UISearchController!
    var listMovies = [Movie]()
    let noRecordLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "No Record", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: .infinity), NSForegroundColorAttributeName: UIColor.lightGray])
        label.textAlignment = .center
        return label
    }()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        navigationItem.title = "Favorite Movies"
        setupViews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    fileprivate func setupViews() {
//        //
        navigationController?.navigationBar.isTranslucent = false
        self.searchController = UISearchController(searchResultsController:  nil)
        self.searchController.searchBar.showsCancelButton = false
        self.searchController.searchBar.sizeToFit()
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
//        //
        self.navigationItem.titleView = searchBar
        searchBar.delegate = self
        self.definesPresentationContext = true
        tableView.register(RowTableView.self, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = bgViewColor
    }
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
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.listMovies.count == 0 {
            self.view.addSubview(noRecordLabel)
            noRecordLabel.anchorCenterXToSuperview()
            noRecordLabel.anchor(noRecordLabel.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        } else {
            noRecordLabel.removeFromSuperview()
        }
        return self.listMovies.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! RowTableView
        cell.movie = self.listMovies[indexPath.item]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        searchBar.resignFirstResponder()
        let detailView = DetailMovieViewController()
        detailView.idMovie = self.listMovies[indexPath.row].id
        self.navigationController?.pushViewController(detailView, animated: true)
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        DataHandler.shared.searchingMovieWith(nameMovie: searchBar.text!, completion: {(data:[Movie]) in
            //
            self.listMovies = data
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
                self.tableView.reloadData()
            }
        })
    }
}
