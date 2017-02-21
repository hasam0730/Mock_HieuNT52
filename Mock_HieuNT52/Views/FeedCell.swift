//
//  File.swift
//  exampleSwift
//
//  Created by Developer on 2/13/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import Foundation

class FeedCell: UICollectionViewCell {
    
    var feedController:FeedController?
    
    var post: Post? {
        didSet {
            setupNameLocationStatusAndProfileImage()
        }
    }
    
    func animate() {
        if let feedCtrl = feedController {
            feedCtrl.animateImageView(statusImageView: statusImageView)
        }
    }
    
    private func setupNameLocationStatusAndProfileImage() {
        // set content label name
        if let name = post?.name {
            let attributedText = NSMutableAttributedString(string: name, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 14)])
            //
            if let city = post?.location?.city, let state = post?.location?.state {
                attributedText.append(NSAttributedString(string: "\n\(city), \(state)  •  ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12), NSForegroundColorAttributeName:
                    UIColor.rgb(red: 155, green: 161, blue: 161)]))
                //
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.lineSpacing = 4
                attributedText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributedText.string.characters.count))
                //
                let attachment = NSTextAttachment()
                attachment.image = UIImage(named: "globe_small")
                attachment.bounds = CGRect(x: 0, y: -2, width: 12, height: 12)
                attributedText.append(NSAttributedString(attachment: attachment))
            }
            nameLabel.attributedText = attributedText
        }
        
        // set content status text
        if let statusText = post?.statusText {
            statusTextView.text = statusText
        }
        
        // set profile image by image name
        if let profileImagename = post?.profileImageName {
            profileImageView.image = UIImage(named: profileImagename)
        }
        
        // set status image by image name
        if let statusImageName = post?.statusImageName {
            statusImageView.image = UIImage(named: statusImageName)
        }
        
        // set numblikes and numbcomments
        if let numLikes = post?.numLikes, let numComments = post?.numComments {
            likesCommentsLabel.text = "\(numLikes) Likes  \(numComments) Comments"
        }
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
//        setupStatusImageViewLoader()
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        //
        self.backgroundColor = .white
        addSubview(nameLabel)
        addSubview(profileImageView)
        addSubview(statusTextView)
        addSubview(statusImageView)
        addSubview(likesCommentsLabel)
        addSubview(dividerLineView)
        addSubview(likeButton)
        addSubview(commentButton)
        addSubview(shareButton)
        //
        statusImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        //
        addConstraintsWithFormat(format: "H:|-8-[v0(44)]-8-[v1]|", views: profileImageView, nameLabel)
        addConstraintsWithFormat(format: "H:|-2-[v0]-0-|", views: statusTextView)
        addConstraintsWithFormat(format: "H:|[v0]|", views: statusImageView)
        addConstraintsWithFormat(format: "H:|-12-[v0]|", views: likesCommentsLabel)
        addConstraintsWithFormat(format: "H:|[v0]|", views: dividerLineView)
        //
        addConstraintsWithFormat(format: "H:|[v0(v1)][v1(v2)][v2]|", views: likeButton, commentButton, shareButton)
        addConstraintsWithFormat(format: "V:|-8-[v0]", views: nameLabel)
        //
        addConstraintsWithFormat(format: "V:|-8-[v0(44)]-0-[v1]-0-[v2(200)]-4-[v3(30)]-4-[v4(0.4)]-4-[v5(44)]|", views: profileImageView, statusTextView, statusImageView, likesCommentsLabel, dividerLineView, likeButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: commentButton)
        addConstraintsWithFormat(format: "V:[v0(44)]|", views: shareButton)
        //
    }
    
    var nameLabel:UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        return label
    }()
    
    let profileImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        return imgView
    }()
    
    let statusTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 15)
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let statusImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFill
        imgView.image = #imageLiteral(resourceName: "zuckdog")
        imgView.layer.masksToBounds = true
        imgView.isUserInteractionEnabled = true
        return imgView
    }()
    
    let likesCommentsLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 230, green: 230, blue: 230)
        return view
    }()
    
    let loader: UIActivityIndicatorView = {
        let indicatorView = UIActivityIndicatorView()
        indicatorView.activityIndicatorViewStyle = .whiteLarge
        indicatorView.hidesWhenStopped = true
        return indicatorView
    }()
    
    func setupStatusImageViewLoader() {
        loader.startAnimating()
        loader.color = .black
        statusImageView.addSubview(loader)
        statusImageView.addConstraintsWithFormat(format: "H:|[v0]|", views: loader)
        statusImageView.addConstraintsWithFormat(format: "V:|[v0]|", views: loader)
    }
    
    let likeButton = FeedCell.buttonForTittle(title: "Like", imageName: #imageLiteral(resourceName: "like"))
    
    let commentButton = FeedCell.buttonForTittle(title: "Comment", imageName: #imageLiteral(resourceName: "comment"))
    
    let shareButton = FeedCell.buttonForTittle(title: "Share", imageName: #imageLiteral(resourceName: "share"))
    
    class func buttonForTittle(title: String, imageName: UIImage) -> UIButton {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setTitleColor(UIColor.rgb(red: 157, green: 161, blue: 172), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setImage(imageName.withRenderingMode(.alwaysOriginal), for: .normal)
        button.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0)
        return button
    }
}

