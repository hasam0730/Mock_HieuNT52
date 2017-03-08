//
//  CellGridTypeMovie.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/23/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import UIKit

class CellGridTypeMovie: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    var movie: Movie? {
        didSet {
            guard let movie = self.movie else { return }
            DispatchQueue.global().async {
                let urlLogoMovie = URL(string: "\(urlImage)\(kLogoSize.w300)\(movie.backdrop_path!)")
                let data = try? Data(contentsOf: urlLogoMovie!)
                DispatchQueue.main.async {
                    if let data = data {
                        self.imgPoster.image = UIImage(data: data)
                        self.loader.stopAnimating()
                    }
                }
            }
            let attributetext = NSMutableAttributedString(string: movie.title!, attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16, weight: .infinity), NSForegroundColorAttributeName: titleColor])
            self.lblTitle.attributedText = attributetext
        }
    }
    // 1.
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // 2.
    func setupViews() {
        self.backgroundColor = bgCellColor
        //
        setupStatusImageViewLoader()
        //
        addSubview(imgPoster)
        addSubview(lblTitle)
        //
        addConstraintsWithFormat(format: "V:|[v0(120)]-0-[v1(30)]|", views: imgPoster, lblTitle)
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: imgPoster)
        addConstraintsWithFormat(format: "H:|-0-[v0]-0-|", views: lblTitle)
    }
    
    // 3.
    let imgPoster: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.image = #imageLiteral(resourceName: "zuckdog")
        return img
    }()
    
    let lblTitle: UILabel = {
        let label = UILabel()
        label.text = "title movie"
        label.textAlignment = .center
        return label
    }()
    
    let loader: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = .white
        return activityIndicator
    }()
    
    func setupStatusImageViewLoader() {
        loader.startAnimating()
        imgPoster.addSubview(loader)
        loader.color = .black
        imgPoster.addConstraintsWithFormat(format: "H:|[v0]|", views: loader)
        imgPoster.addConstraintsWithFormat(format: "V:|[v0]|", views: loader)
    }
}
