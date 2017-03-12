//
//  PopupViewController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/8/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class PopupView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        self.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.backgroundColor = .black
        self.alpha = 0.0
        self.makingBorderRadius(view: self)
        //
        let textLabel = UILabel(frame: CGRect(x: 0, y: 35, width: 100, height: 30))
        textLabel.textColor = UIColor.white
        textLabel.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        textLabel.textAlignment = .center
        textLabel.font = UIFont(name: textLabel.font.fontName, size: 16)
        textLabel.text = "Saved"
        self.addSubview(textLabel)
    }
}
