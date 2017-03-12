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
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        //
        self.collectionView?.backgroundColor = .black
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
        preparingConditionGetData()
        //
        NotificationCenter.default.addObserver(self, selector: #selector(preparingConditionGetData), name: FILTER_NOTIFICATION , object: nil)
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
    
    func preparingConditionGetData() {
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
            getData(urlString: urlMovieListPopular, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
            navigationItem.title = "Popular Movies"
        case 1: // top rated movie
            getData(urlString: urlMovieListTopRated, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
            navigationItem.title = "TopRated Movies"
        case 2: // upcoming movie
            getData(urlString: urlMovieListUpComing, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
            navigationItem.title = "UpComing Movies"
        case 3: // nowplaying movie
            getData(urlString: urlMovieListNowPlaying, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
            navigationItem.title = "NowPlaying Movies"
        default: break
        }
    }
    
//    func handlingFilterMovie(notifnotification: NSNotification) {
//        preparingConditionGetData()
//        let dataNotifi = notifnotification.userInfo
//        guard let data = dataNotifi else { return }
//        let modeFilter = data[kSetting.settingModeFilter.rawValue] as! Int
//        let modeSort = data[kSetting.settingModeSort.rawValue] as! Int
//        let rateMovie = data[kSetting.settingRateMovie.rawValue] as! Float
//        let numberLoad = data[kSetting.settingNumberLoadding.rawValue] as! Int
//        let releaseYear = data[kSetting.settingReleaseYear.rawValue] as! Int
//        switch modeFilter {
//            case 1: // popular movie
//                getData(urlString: urlMovieListPopular, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
//            case 2: // top rated movie
//                getData(urlString: urlMovieListTopRated, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
//            case 3: // upcoming movie
//                getData(urlString: urlMovieListUpComing, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
//            case 4: // nowplaying movie
//                getData(urlString: urlMovieListNowPlaying, modeSort: modeSort, rateMovie: rateMovie, numberLoad: numberLoad, releaseYear: releaseYear)
//            default: break
//        }
//    }
    
    fileprivate func getData(urlString: String? = urlMovieListPopular, modeSort: Int? = 5, rateMovie:Float? = 0.0 , numberLoad: Int? = 1, releaseYear: Int = 1970) {
        DataHandler.shared.gettingMovieFrom(urlString: urlString!, pageNumber: 1, completion: {(data:[Movie]) in
            //
            self.dataList = data
            self.filteredMovie = self.dataList.filter { Float($0.vote_average!) >= Float(rateMovie!)}
            //
            if let sorted = modeSort {
                if (sorted == 0) {
                    self.dataList = data.sorted(by: { $0.popularity! > $1.popularity! })
                } else {
                    self.dataList = data.sorted(by: { $0.vote_average! > $1.vote_average! })
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
            cell.movie = self.dataList[indexPath.item]
            return cell
        case .grid:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIDGrid, for: indexPath) as! CellGridTypeMovie
            cell.movie = self.dataList[indexPath.item]
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
        let detailView = DetailMovieViewController()
        detailView.idMovie = self.dataList[indexPath.item].id
        self.navigationController?.pushViewController(detailView, animated: true)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: RELOAD_NOTIFICATION , object: nil)
        NotificationCenter.default.removeObserver(self, name: FILTER_NOTIFICATION , object: nil)
    }

}

