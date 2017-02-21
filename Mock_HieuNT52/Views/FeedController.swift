//
//  ViewController.swift
//  exampleSwift
//
//  Created by Developer on 12/31/16.
//  Copyright © 2016 Developer. All rights reserved.
//

import UIKit
import Foundation

let cellId = "cell"
var posts = Posts()
//MARK: Controller
class FeedController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var posts = [Post]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //
        if let path = Bundle.main.path(forResource: "all_posts", ofType: "json") {
            do {
                let data = try(Data(contentsOf: URL(fileURLWithPath: path), options: NSData.ReadingOptions.mappedIfSafe))
                let jsonDictionary = try(JSONSerialization.jsonObject(with: data, options: .mutableContainers)) as? [String: Any]
                if let postsArray = jsonDictionary?["posts"] as? [[String: AnyObject]] {
                    //
                    self.posts = [Post]()
                    for postDictionary in postsArray {
                        let post = Post()
                        post.setValuesForKeys(postDictionary)
                        self.posts.append(post)
                    }
                }
            } catch let error {
                print(error)
            }
        }
        //
        let memoryCapacity = 500 * 1024 * 1024
        let diskCapacity = 500 * 1024 * 1024
        let urlCache = URLCache(memoryCapacity: memoryCapacity, diskCapacity: diskCapacity, diskPath: "myDiskPath")
        URLCache.shared = urlCache
        //
        navigationItem.title = "Facebook Feed"
        
        collectionView?.alwaysBounceVertical = true
        
        collectionView!.backgroundColor = UIColor.rgb(red: 200, green: 200, blue: 200)
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let feedCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! FeedCell
        feedCell.post = posts[indexPath.item]
        feedCell.feedController = self
        return feedCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let statusText = posts[indexPath.item].statusText {
            let rect = NSString(string: statusText).boundingRect(with: CGSize(width: view.frame.width, height: 1000), options: NSStringDrawingOptions.usesFontLeading.union(NSStringDrawingOptions.usesLineFragmentOrigin), attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)], context: nil)
            let knowHeight: CGFloat = 8 + 44 + 4 + 4 + 200 + 8 + 24 + 8 + 44
            
            return CGSize(width: view.frame.width, height: rect.height + knowHeight + 44)
        }
        
        return CGSize(width: view.frame.width, height: 500)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        collectionView?.collectionViewLayout.invalidateLayout()
    }
    //
    let blackBackground = UIView()
    var statusImageView = UIImageView()
    var zoomImageView = UIImageView()
    var navBarCoverView = UIView()
    var tabbarCoverView = UIView()
    //
    func zoomOut() {
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            UIView.animate(withDuration: 0.5, animations: { () -> Void in
                self.zoomImageView.frame = startingFrame
                self.blackBackground.alpha = 0
                self.navBarCoverView.alpha = 0
                self.tabbarCoverView.alpha = 0
                
                }, completion: { (didComplete) -> Void in
                    self.blackBackground.removeFromSuperview()
                    self.zoomImageView.removeFromSuperview()
                    self.statusImageView.alpha = 1
                    self.navBarCoverView.removeFromSuperview()
                    self.tabbarCoverView.removeFromSuperview()
            })
        }
    }
    
    func animateImageView(statusImageView: UIImageView) {
        // get starting frame
        self.statusImageView = statusImageView
        if let startingFrame = statusImageView.superview?.convert(statusImageView.frame, to: nil) {
            //
            self.statusImageView.alpha = 0
            // black background
            blackBackground.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            blackBackground.frame = self.view.frame
            blackBackground.alpha = 0
            self.view.addSubview((self.blackBackground))
            // navbar cover view
            navBarCoverView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            navBarCoverView.frame = CGRect(x: 0, y: 0, width: 1000, height: 20 + 44)
            navBarCoverView.alpha = 0
            // tabbar cover view
            tabbarCoverView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            tabbarCoverView.alpha = 0
            //
            if let keyWindow = UIApplication.shared.keyWindow {
                keyWindow.addSubview(navBarCoverView)
                tabbarCoverView.frame = CGRect(x: 0, y: keyWindow.frame.height - 49, width: 1000, height: 49)
                keyWindow.addSubview(tabbarCoverView)
            }
            //
            zoomImageView.frame = startingFrame
            zoomImageView.image = statusImageView.image
            zoomImageView.isUserInteractionEnabled = true
            zoomImageView.contentMode = .scaleAspectFill
            zoomImageView.clipsToBounds = true
            view.addSubview(zoomImageView)
            //
            zoomImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            blackBackground.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOut)))
            //
            UIView.animate(withDuration: 0.5, animations: { ()-> Void in
                let height = ((self.view.frame.width / startingFrame.width) * startingFrame.height )
                self.zoomImageView.frame = CGRect(x: 0, y: self.view.frame.height / 2 - height / 2, width: self.view.frame.width, height: height)
                self.blackBackground.alpha = 1
                self.navBarCoverView.alpha = 1
                self.tabbarCoverView.alpha = 1
            })
        }
    }

}




