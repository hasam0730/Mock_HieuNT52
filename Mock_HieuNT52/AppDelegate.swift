//
//  AppDelegate.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        //
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        //
        UINavigationBar.appearance().barTintColor = headerColor
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)]
        UITabBar.appearance().tintColor = headerColor
        //
        application.statusBarStyle = .lightContent
        //
        let revealController = SWRevealViewController()
        //
        revealController.frontViewController = CustomTabBarController()
        revealController.rearViewController = UserController()
        //
        window?.rootViewController = revealController
        //
        determiningSizeIphone()
        //
        return true
    }
    
    func determiningSizeIphone() {
        let widthScreen = UIScreen.main.bounds.size.width
        if (widthScreen == 375) { // IP7
            typeIphone = sizeIPhone.IPhone7
        } else if (widthScreen == 414) { // IP7+
            typeIphone = sizeIPhone.IPhone7Plus
        } else if (widthScreen == 320) { // IP SE
            typeIphone = sizeIPhone.IPhoneSE
        }
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}
