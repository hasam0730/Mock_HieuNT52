//
//  MoviesList.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

let cellIDList = "cellIdList"
let cellIDGrid = "cellIdGrid"

class MoviesListController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    //
    var dataList = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        self.collectionView?.backgroundColor = .white
        //
        NotificationCenter.default.addObserver(forName: RELOAD_NOTIFICATION, object: nil, queue: nil, using: {_ in 
            self.handleReloadNotificaiotn()})
        //
        navigationItem.title = "Popular Movies"
        //
        self.setupLeftItem()
        self.setupRightItem()
        self.setupRremainingNavItems()
        //
        self.registerCellClass()
        //
        self.getData()
        //
    }
    
    fileprivate func getData() {
        //
        let datahandler = DataHandler()
        datahandler.gettingPopularMovieFromData(pageNumber: 1, completion: {(data:[Movie]) in
            self.dataList = data
            DispatchQueue.main.async {
                self.collectionView?.reloadData()
            }
        })
    }
    
    //
    fileprivate func handleReloadNotificaiotn() {
        collectionView?.reloadData()
    }
    //
    
    func registerCellClass() {
        collectionView?.register(CellListTypeMovie.self, forCellWithReuseIdentifier: cellIDList)
        collectionView?.register(CellGridTypeMovie.self, forCellWithReuseIdentifier: cellIDGrid)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.dataList.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch statusDisplayListMovie {
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDList, for: indexPath) as! CellListTypeMovie
            cell.movie = self.dataList[indexPath.item]
            return cell
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDGrid, for: indexPath) as! CellGridTypeMovie
            cell.movie = self.dataList[indexPath.item]
            cell.layer.borderWidth = 0.3
            cell.layer.borderColor = headerColor.cgColor
            cell.clipsToBounds = true
            return cell
        }
    }
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch statusDisplayListMovie {
        case .list:
            return CGSize(width: view.frame.width, height: 150)
        case .grid:
            return CGSize(width: self.view.frame.width/2 , height: 150)
        }
        
    }
    //
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    //
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailView = DetailMovieViewController()
        detailView.idMovie = self.dataList[indexPath.item].id
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: RELOAD_NOTIFICATION , object: nil)
    }

}

