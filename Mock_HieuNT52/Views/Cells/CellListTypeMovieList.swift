//
//  CellListTypeMovieList.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class CellListTypeMovie: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var movie: Movie? {
        didSet {
            guard let movie = self.movie else { return }
            // title movie
            let attributeTextTitle = NSMutableAttributedString(string: "🏷 " + movie.title!, attributes: [NSFontAttributeName: UIFont.boldSystemFont(ofSize: 18), NSForegroundColorAttributeName: titleColor])
            self.titleLabel.attributedText = attributeTextTitle
            // logo movie
            DispatchQueue.global().async {
                let urlLogoMovie = URL(string: "\(urlImage)\(kLogoSize.w300)\(movie.backdrop_path!)")
                let data = try? Data(contentsOf: urlLogoMovie!)
                DispatchQueue.main.async {
                    if let data = data {
                        self.imageLogoMovie.image = UIImage(data: data)
                        self.loader.stopAnimating()
                    } 
                }
            }
            // release and rate text
            let attributeTextReleaseAndRate = NSMutableAttributedString(string: "🗓 Release Date: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13, weight: .infinity)])
            attributeTextReleaseAndRate.append(NSAttributedString(string: "\(movie.release_date!)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)]))
            attributeTextReleaseAndRate.append(NSAttributedString(string: "\n⭐ Rating: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13, weight: .infinity)]))
            attributeTextReleaseAndRate.append(NSAttributedString(string: "\(movie.vote_average!)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 12)]))
            //
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.lineSpacing = 5
            attributeTextReleaseAndRate.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributeTextReleaseAndRate.string.characters.count))
            //
            self.releaseAndRateTextView.attributedText = attributeTextReleaseAndRate
            
            // overview text
            let attributeTextOverview = NSMutableAttributedString(string: "\(movie.overview!)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13), NSForegroundColorAttributeName: UIColor.darkGray])
            self.overviewTextView.attributedText = attributeTextOverview
            
            // adult label
            self.adultFlagLabel.isHidden = movie.adult! == true ? false : true
            
            //
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = UIColor.rgb(red: 245, green: 247, blue: 249)
        //
        setupStatusImageViewLoader()
        addSubview(titleLabel)
        addSubview(imageLogoMovie)
        addSubview(adultFlagLabel)
        addSubview(releaseAndRateTextView)
        addSubview(overviewTextView)
        addSubview(separatorLine)
        //
        addConstraintsWithFormat(format: "V:|-8-[v0(20)]-8-[v1(100)]", views: titleLabel, imageLogoMovie)
        addConstraintsWithFormat(format: "V:[v0]|", views: separatorLine)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-|", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-8-[v0(100)]-8-[v1]", views: imageLogoMovie, releaseAndRateTextView)
        addConstraintsWithFormat(format: "H:|-8-[v0]-8-[v1]-8-|", views: imageLogoMovie, overviewTextView)
        addConstraintsWithFormat(format: "H:|-4-[v0]-4-|", views: separatorLine)
        //
        
        addConstraint(NSLayoutConstraint(item: releaseAndRateTextView, attribute: .top, relatedBy: .equal, toItem: imageLogoMovie, attribute: .top, multiplier: 1, constant: -4))
        
        //
        addConstraint(NSLayoutConstraint(item: overviewTextView, attribute: .top, relatedBy: .equal, toItem: releaseAndRateTextView, attribute: .bottom, multiplier: 1, constant: 0))
        addConstraint(NSLayoutConstraint(item: overviewTextView, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 70))
        //
        addConstraint(NSLayoutConstraint(item: adultFlagLabel, attribute: .top, relatedBy: .equal, toItem: titleLabel, attribute: .bottom, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: adultFlagLabel, attribute: .left, relatedBy: .equal, toItem: releaseAndRateTextView, attribute: .right, multiplier: 1, constant: 8))
        addConstraint(NSLayoutConstraint(item: adultFlagLabel, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 44))
        //
        
        addConstraint(NSLayoutConstraint(item: separatorLine, attribute: .height, relatedBy: .equal, toItem: self, attribute: .height, multiplier: 0, constant: 1))
        
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
//        label.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let imageLogoMovie: UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        //
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
//        textView.backgroundColor = #colorLiteral(red: 0.7450980544, green: 0.1568627506, blue: 0.07450980693, alpha: 1)
        textView.textContainer.maximumNumberOfLines = 2
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.textContainerInset = UIEdgeInsets(top: 5, left: -5, bottom: 0, right: -5)
        return textView
    }()
    
    let overviewTextView: InsetLabel = {
       let textView = InsetLabel()
//        textView.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.numberOfLines = 4
        return textView
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = headerColor
        return view
    }()
    
    let loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .white
        return activityIndicator
    }()
    
    func setupStatusImageViewLoader() {
        loader.startAnimating()
        imageLogoMovie.addSubview(loader)
        loader.color = .black
        imageLogoMovie.addConstraintsWithFormat(format: "H:|[v0]|", views: loader)
        imageLogoMovie.addConstraintsWithFormat(format: "V:|[v0]|", views: loader)
    }
}


class InsetLabel: UILabel
{
    let topInset = CGFloat(-40)
    let bottomInset = CGFloat(-40)
    let leftInset = CGFloat(0)
    let rightInset = CGFloat(0)
    
    override func drawText(in rect: CGRect)
    {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: UIEdgeInsetsInsetRect(rect, insets))
    }
}

