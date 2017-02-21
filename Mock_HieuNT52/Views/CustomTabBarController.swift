//
//  CustomTabBarController.swift
//  exampleSwift
//
//  Created by Developer on 2/14/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import UIKit

class CustomTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // 1.
        let moviesListController = MoviesListController(collectionViewLayout: UICollectionViewFlowLayout())
        let firstNavigationController = UINavigationController(rootViewController: moviesListController)
        firstNavigationController.title = "Movies List"
        firstNavigationController.tabBarItem.image = UIImage(named: "messenger_icon")
        // 2.
        let favoriteMoviesController = FavoriteMoviesController()
        let secondNavigationController = UINavigationController(rootViewController: favoriteMoviesController)
        secondNavigationController.title = "Favorite Movies"
        secondNavigationController.tabBarItem.image = UIImage(named: "globe_icon")
        // 3.
        let settingController = SettingController()
        let thirdNavigationController = UINavigationController(rootViewController: settingController)
        thirdNavigationController.title = "Setting"
        thirdNavigationController.tabBarItem.image = UIImage(named: "news_feed_icon")
        // 4.
        let abboutController = AbboutController()
        let fourthNavigationController = UINavigationController(rootViewController: abboutController)
        fourthNavigationController.title = "Abbout"
        fourthNavigationController.tabBarItem.image = UIImage(named: "more_icon")
        //
        viewControllers = [firstNavigationController, secondNavigationController, thirdNavigationController, fourthNavigationController]
        tabBar.isTranslucent = false
        //
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
}
