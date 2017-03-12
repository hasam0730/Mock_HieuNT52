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
        firstNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Movie")
        // 2.
        let favoriteMoviesController = FavoriteMoviesController()
        let secondNavigationController = UINavigationController(rootViewController: favoriteMoviesController)
        secondNavigationController.title = "Favorite Movies"
        secondNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Reminder")
        // 3.
        let settingController = SettingController()
        let thirdNavigationController = UINavigationController(rootViewController: settingController)
        thirdNavigationController.title = "Setting"
        thirdNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Settings")
        // 4.
        let abboutController = AbboutController()
        let fourthNavigationController = UINavigationController(rootViewController: abboutController)
        fourthNavigationController.title = "Abbout"
        fourthNavigationController.tabBarItem.image = #imageLiteral(resourceName: "About")
        // 5.
        let searchtController = SearchViewController()
        let fifthNavigationController = UINavigationController(rootViewController: searchtController)
        fifthNavigationController.title = "Search View"
        fifthNavigationController.tabBarItem.image = #imageLiteral(resourceName: "Search")
        //
        viewControllers = [firstNavigationController, secondNavigationController, thirdNavigationController, fourthNavigationController, fifthNavigationController]
        tabBar.isTranslucent = false
        //
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = headerColor.cgColor
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
        tabBar.barTintColor = headerColor
    }
}
