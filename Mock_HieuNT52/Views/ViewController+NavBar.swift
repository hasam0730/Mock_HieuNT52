//
//  CustomTabBarController+NavBar.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/22/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    // 1
    func setupRightItem() {
        let gridButton = UIButton(type: .system)
        gridButton.setImage(#imageLiteral(resourceName: "Grid").withRenderingMode(.alwaysOriginal), for: .normal)
        gridButton.frame.size = CGSize(width: 35, height: 35)
        gridButton.addTarget(self, action: #selector(changeCollectionTypeDisplay), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: gridButton)
    }
    
    // 2
    func changeCollectionTypeDisplay() {
        if statusDisplayListMovie == .list {
            statusDisplayListMovie = .grid
            let Button = initButtonWithImage(imgIcon: #imageLiteral(resourceName: "List"), width: 35.0, height: 35.0)
            Button.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                Button.alpha = 1
            }, completion: { void in
                NotificationCenter.default.post(name: RELOAD_NOTIFICATION, object: nil)
            })
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: Button)
        } else {
            statusDisplayListMovie = .list
            let Button = initButtonWithImage(imgIcon: #imageLiteral(resourceName: "Grid"), width: 35.0, height: 35.0)
            Button.alpha = 0
            UIView.animate(withDuration: 0.5, animations: {
                Button.alpha = 1
            }, completion: { void in
                NotificationCenter.default.post(name: RELOAD_NOTIFICATION, object: nil)
            })
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: Button)
        }
    }
    
    // 4
    func initButtonWithImage(imgIcon: UIImage, width: CGFloat, height: CGFloat) -> UIButton {
        let button = UIButton(type: .system)
        button.setImage(imgIcon.withRenderingMode(.alwaysOriginal), for: .normal)
        button.frame.size = CGSize(width: width, height: height)
        button.addTarget(self, action: #selector(changeCollectionTypeDisplay), for: .touchUpInside)
        return button
    }
    
    func setupLeftItem() {
        let barBtnItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Menu").withRenderingMode(.alwaysOriginal), style: .plain, target: self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)))
        navigationItem.leftBarButtonItem = barBtnItem
        //
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }
    
    func setupRremainingNavItems() {
        //
        navigationController?.navigationBar.isTranslucent = false
        //
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        // add line to navigationBar (top collection view)
        let navBarSeperatorView = UIView()
        navBarSeperatorView.backgroundColor = UIColor.rgb(red: 220, green: 220, blue: 220)
        view.addSubview(navBarSeperatorView)
    }
}
