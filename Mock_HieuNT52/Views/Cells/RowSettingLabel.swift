//
//  CellForRowTableView.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/4/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import SDWebImage

class RowSettingLabel: UITableViewCell {
    
    var content: String? {
        didSet {
            titleLabel.text = content
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    let imgCheck: UIImageView = {
       let imgCheck = UIImageView()
        imgCheck.image = #imageLiteral(resourceName: "Checkmark")
        return imgCheck
    }()
    
    func setupViews() {
        addSubview(titleLabel)
        //
        addConstraintsWithFormat(format: "V:|-[v0]-|", views: titleLabel)
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: titleLabel)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    
}
