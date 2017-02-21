//
//  CellListTypeMovieList.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class CellListTypeMovieList: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        //
        addSubview(titleLabel)
        addSubview(imagePoster)
        addSubview(adultFlagLabel)
        addSubview(releaseAndRateTextView)
        addSubview(overviewTextView)
        //
        addConstraintsWithFormat(format: "V:|-8-[v0(30)]-8-[v1(100)]", views: titleLabel, imagePoster)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0(100)]-8-[v1(150)]", views: imagePoster, releaseAndRateTextView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-[v1]-8-|", views: imagePoster, overviewTextView)
        //
        
        addConstraint(NSLayoutConstraint(item: releaseAndRateTextView, attribute: .top, relatedBy: .equal, toItem: imagePoster, attribute: .top, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: releaseAndRateTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        
        addConstraint(NSLayoutConstraint(item: overviewTextView, attribute: .top, relatedBy: .equal, toItem: releaseAndRateTextView, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: overviewTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 48))
        //
        addConstraint(NSLayoutConstraint(item: adultFlagLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: adultFlagLabel, attribute: .left, relatedBy: .equal, toItem: releaseAndRateTextView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: adultFlagLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        addConstraint(NSLayoutConstraint(item: adultFlagLabel, attribute: .width, relatedBy: .equal, toItem: self, attribute: .width, multiplier: 0, constant: 44))
        
        
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imagePoster: UIImageView = {
        let imgView = UIImageView()
        imgView.image = #imageLiteral(resourceName: "zuckdog")
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    
    let adultFlagLabel: UILabel = {
        let label = UILabel()
        label.text = "Adult"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseAndRateTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        textView.textContainer.maximumNumberOfLines = 2
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let overviewTextView: UITextView = {
       let textView = UITextView()
        textView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
}
