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
    var gradientLayer: CAGradientLayer!
    var dataList = [Movie]()
    var filteredMovie = [Movie]()
    let noRecordLabel: UILabel = {
        let label = UILabel()
        label.attributedText = NSAttributedString(string: "No Record", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 20, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray])
        label.textAlignment = .center
        return label
    }()
    var urlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        //
        self.collectionView?.backgroundColor = bgCellColor
        self.collectionView?.alwaysBounceVertical = true
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
//        checkingDateUserDefault()
        preparingConditionFilterData()
        //
        NotificationCenter.default.addObserver(self, selector: #selector(preparingConditionFilterData), name: FILTER_NOTIFICATION , object: nil)
    }
    
    func checkingDateUserDefault() {
        // * check nil setting *
        let setting = gettingDataSettingDefault()
        if let _ = setting.modeFilter {} else {
            settingDataDefault(settingModeFilter: 1) }
        if let _ = setting.modeSort {} else {
            settingDataDefault(settingModeSort: 5) }
        if let _ = setting.rateMovie {} else {
            settingDataDefault(settingRateMovie: 1.0) }
        if let _ = setting.releaseYear {} else {
            settingDataDefault(settingReleaseYear: 1970) }
        if let _ = setting.numberLoad {} else {
            settingDataDefault(settingNumberLoadding: 1) }
        // * check nil user *
        let user = gettingDataUserDefault()
        if let _ = user.name {} else { settingDataDefault(name: "nguyen trung hieu") }
        if let _ = user.avatar {} else { settingDataDefault(avatar: "/Users/developer/Library/Developer/CoreSimulator/Devices/0954154B-B595-47C6-A9C8-E404C7D527CF/data/Containers/Data/Application/B4DAE623-5A07-4C92-B4D7-389D042A7D6F/Documents/asset.JPG") }
        if let _ = user.DOB {} else { settingDataDefault(dob: 1615177269.0) }
        if let _ = user.Email {} else { settingDataDefault(email: "Hasam@gmail") }
        if let _ = user.Sex {} else { settingDataDefault(sex: true) }
    }
    
    func preparingConditionFilterData() {
        pageNumber = 1 // reset số đếm page đã load trước đó sau khi thay đổi trong setting
        //
        let setting = gettingDataSettingDefault()
        let modeFilter = setting.modeFilter! as Int
        let modeSort = setting.modeSort!  as Int
        let rateMovie = setting.rateMovie!  as Float
        let numberLoad = setting.numberLoad!  as Int
        let releaseYear = setting.releaseYear! as Int
        //
        switch modeFilter {
        case 0: // popular movie
            urlString = urlMovieListPopular
            getData(urlString: urlString, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
            navigationItem.title = "Popular Movies"
        case 1: // top rated movie
            urlString = urlMovieListTopRated
            getData(urlString: urlString, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
            navigationItem.title = "TopRated Movies"
        case 2: // upcoming movie
            urlString = urlMovieListUpComing
            getData(urlString: urlString, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
            navigationItem.title = "UpComing Movies"
        case 3: // nowplaying movie
            urlString = urlMovieListNowPlaying
            getData(urlString: urlString, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
            navigationItem.title = "NowPlaying Movies"
        default: break
        }
    }
    
    fileprivate func getData(urlString: String? = urlMovieListPopular, modeSort: Int? = 0, rateMovie:Float? = 0.0 , numberLoad: Int? = 1, releaseYear: Int? = 1970) {
        DataHandler.shared.gettingMovieFrom(urlString: urlString!, pageNumber: 1, completion: {(data:[Movie]) in
            let setting = self.gettingDataSettingDefault()
            //
            self.dataList = data
            self.filteredMovie = self.dataList.filter { Float($0.vote_average!) >= Float(rateMovie!)}
            //
            var arr = [Movie]()
            for item in self.filteredMovie {
                if let releaseTime = Int((item.release_date?.components(separatedBy: "-")[0])!) {
                    if setting.releaseYear! <= releaseTime {
                        arr.append(item)
                    }
                }
            }
            self.filteredMovie = arr
            //
            if let sorted = modeSort {
                if (sorted == 0) {
                    self.filteredMovie = self.filteredMovie.sorted(by: { $0.popularity! > $1.popularity! })
                } else {
                    self.filteredMovie = self.filteredMovie.sorted(by: { $0.vote_average! > $1.vote_average! })
                }
            } else {
                
            }
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
        if self.filteredMovie.count == 0 {
            collectionView.addSubview(noRecordLabel)
            noRecordLabel.anchorCenterXToSuperview()
            noRecordLabel.anchor(noRecordLabel.topAnchor, left: nil, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 100)
        } else {
            noRecordLabel.removeFromSuperview()
        }
        return self.filteredMovie.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch statusDisplayListMovie {
        case .list:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDList, for: indexPath) as! CellListTypeMovie
            cell.alpha = 0.0
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 0.0,
                           options: .overrideInheritedCurve,
                           animations: { cell.alpha = 1.0 }, completion: { _ in })
            cell.movie = self.filteredMovie[indexPath.item]
            return cell
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDGrid, for: indexPath) as! CellGridTypeMovie
            cell.movie = self.filteredMovie[indexPath.item]
            cell.alpha = 0.0
            UIView.animate(withDuration: 1,
                           delay: 0,
                           usingSpringWithDamping: 1.0,
                           initialSpringVelocity: 0.5,
                           options: .transitionFlipFromLeft,
                           animations: { cell.alpha = 1.0 }, completion: { _ in })
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
//        let detailView = DetailMovieViewController()
//        detailView.idMovie = self.filteredMovie[indexPath.item].id
//        self.navigationController?.pushViewController(detailView, animated: true)
        print(indexPath.row)
    }
    //
    var pageNumber = 1
    override func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        //
        let setting = gettingDataSettingDefault()
//        let modeFilter = setting.modeFilter! as Int
        let modeSort = setting.modeSort!  as Int
        let rateMovie = setting.rateMovie!  as Float
        let numberLoad = setting.numberLoad!  as Int
//        let releaseYear = setting.releaseYear! as Int
        //
        if indexPath.row > self.filteredMovie.count - 2 {
            print(gettingDataSettingDefault().numberLoad ?? 0)
            if pageNumber < numberLoad {
                pageNumber += 1
                DataHandler.shared.gettingMovieFrom(urlString: urlString!, pageNumber: pageNumber, completion: {(data:[Movie]) in
                    //
                    var dataMoreMovie = data.filter { return Float($0.vote_average!) >= Float(rateMovie) && setting.releaseYear! <= Int(($0.release_date?.components(separatedBy: "-")[0])!)!}
                    if (modeSort == 0) {
                        dataMoreMovie = dataMoreMovie.sorted(by: { $0.popularity! > $1.popularity! })
                    } else {
                        dataMoreMovie = dataMoreMovie.sorted(by: { $0.vote_average! > $1.vote_average! })
                    }
                    for item in dataMoreMovie {
                        self.filteredMovie.append(item)
                    }
                    DispatchQueue.main.async {
                        self.collectionView?.reloadData()
                    }
                })
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: RELOAD_NOTIFICATION , object: nil)
        NotificationCenter.default.removeObserver(self, name: FILTER_NOTIFICATION , object: nil)
    }

}

