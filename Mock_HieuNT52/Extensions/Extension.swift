//
//  File.swift
//  exampleSwift
//
//  Created by Developer on 2/13/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit


extension UIColor {
    class func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addConstraintsWithFormat(format: String, views:UIView...) {
        var viewsDictionary = [String:UIView]()
        for(index, view) in views.enumerated() {
            let key = "v\(index)"
            viewsDictionary[key] = view
            view.translatesAutoresizingMaskIntoConstraints = false
        }
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format,
                                                      options: NSLayoutFormatOptions(),
                                                      metrics: nil,
                                                      views: viewsDictionary))
    }
}

extension UIViewController {
    func showAlertController( titleOfAlert: String, messageOfAlert : String, actionSave : @escaping (()->Void), actionCancel : @escaping (()->Void) ) {
        let refreshAlert = UIAlertController(title: titleOfAlert, message: messageOfAlert, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Save", style: UIAlertActionStyle.default) { action in
            actionSave()
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { action in
            actionCancel()
        }
        refreshAlert.addAction(okAction)
        refreshAlert.addAction(cancelAction)
        self.present(refreshAlert, animated: true, completion: nil)
    }
}
