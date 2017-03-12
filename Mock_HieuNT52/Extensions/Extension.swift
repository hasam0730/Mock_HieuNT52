//
//  File.swift
//  exampleSwift
//
//  Created by Developer on 2/13/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import CoreData

extension UIColor {
    class func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
}

extension UIView {
    func addingGradientLayer(view: UIView, colorStartPoint: UIColor, colorEndPoint: UIColor, size: CGSize) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame.size = size
        gradientLayer.colors = [colorStartPoint.cgColor, colorEndPoint.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        view.layer.addSublayer(gradientLayer)
    }
    
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
    
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        
        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    public func anchorCenterXToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerXAnchor {
            centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    public func anchorCenterYToSuperview(constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let anchor = superview?.centerYAnchor {
            centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
        }
    }
    
    
    func addingShadowTo(view: UIView) {
        view.layer.shadowOffset = .zero
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.5
        view.layer.masksToBounds = false
        view.layer.shouldRasterize = true
    }
    
    func makingBorderRadius(view: UIView) {
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
    }
}

extension UIViewController {
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    // 1
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    // 2
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // 3
    func gettingImageAvatarByDocument() -> UIImage {
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory, nsUserDomainMask, true)
        if let dirPath          = paths.first
        {
            let imageURL = URL(fileURLWithPath: dirPath).appendingPathComponent("asset.JPG")
            let image    = UIImage(contentsOfFile: imageURL.path)
            if let img = image {
                return img
            } else {
                return UIImage()
            }
            
        }
        return UIImage()
    }
    
    // 4
    func castingTimeintervalToDateString(timeinterval: Double, formatter: String? = "dd-MM-yyyy HH:mm:ss") -> String {
        let date = NSDate(timeIntervalSince1970: timeinterval) as Date
        //
        let dateformatter = DateFormatter()
        dateformatter.locale = Locale.current
        dateformatter.dateFormat = formatter!
        let dateStr = dateformatter.string(from: date)
        //
        return dateStr
    }
    
    // 5
    func settingDataDefault(avatar: String? = nil, email: String? =  nil, name: String? = nil, dob: Double? = nil, sex: Bool? = nil, settingRateMovie: Float? = nil, settingReleaseYear: Int? = nil, settingNumberLoadding: Int? = nil, settingModeFilter: Int? = nil, settingModeSort: Int? = nil) {
        let userdefault = UserDefaults.standard
        if let avatar = avatar {
            userdefault.set(avatar, forKey: kUser.avatar.rawValue)
        }
        if let email = email {
            userdefault.set(email, forKey: kUser.email.rawValue)
        }
        if let name = name {
            userdefault.set(name, forKey: kUser.name.rawValue)
        }
        if let dob = dob {
            userdefault.set(dob, forKey: kUser.DOB.rawValue)
        }
        if let sex = sex {
            userdefault.set(sex as Bool, forKey: kUser.sex.rawValue)
        }
        if let rateMovie = settingRateMovie {
            userdefault.set(rateMovie as Float, forKey: kSetting.settingRateMovie.rawValue)
        }
        if let releaseYear = settingReleaseYear {
            userdefault.set(releaseYear, forKey: kSetting.settingReleaseYear.rawValue)
        }
        if let numberLoad = settingNumberLoadding {
            userdefault.set(numberLoad, forKey: kSetting.settingNumberLoadding.rawValue)
        }
        if let modefilter = settingModeFilter {
            userdefault.set(modefilter, forKey: kSetting.settingModeFilter.rawValue)
        }
        if let modesort = settingModeSort {
            userdefault.set(modesort, forKey: kSetting.settingModeSort.rawValue)
        }
    }
//    /Users/developer/Library/Developer/CoreSimulator/Devices/0954154B-B595-47C6-A9C8-E404C7D527CF/data/Containers/Data/Application/ACB1A842-58AF-4C14-9A35-7E67F02CCA13/Documents/asset.JPG
    // 6
    func deletingFileWith(path: String) {
        let fileManager = FileManager.default
        do {
            try fileManager.removeItem(atPath: path)
        } catch let error as NSError {
            print(error.debugDescription)
        }
    }
    
    // 7
    func gettingDataUserDefault() -> User {
        let userdefault = UserDefaults.standard
        var user = User()
        user.name = userdefault.value(forKey: kUser.name.rawValue) as? String ?? "nguyen trung hieu"
        user.avatar = userdefault.value(forKey: kUser.avatar.rawValue) as? String ?? "/Users/developer/Library/Developer/CoreSimulator/Devices/0954154B-B595-47C6-A9C8-E404C7D527CF/data/Containers/Data/Application/B4DAE623-5A07-4C92-B4D7-389D042A7D6F/Documents/asset.JPG"
        user.DOB = userdefault.value(forKey: kUser.DOB.rawValue) as? Double ?? 1615177269.0
        user.Email = userdefault.value(forKey: kUser.email.rawValue) as? String ?? "Hasam@gmail"
        user.Sex = userdefault.value(forKey: kUser.sex.rawValue) as? Bool ?? true
        return user
    }
    
    func gettingDataSettingDefault() -> Setting {
        let userdefault = UserDefaults.standard
        var setting = Setting()
        setting.rateMovie = userdefault.value(forKey: kSetting.settingRateMovie.rawValue) as? Float ?? 5.0
        setting.releaseYear = userdefault.value(forKey: kSetting.settingReleaseYear.rawValue) as? Int ?? 1970
        setting.numberLoad = userdefault.value(forKey: kSetting.settingNumberLoadding.rawValue) as? Int ?? 1
        setting.modeFilter = userdefault.value(forKey: kSetting.settingModeFilter.rawValue) as? Int ?? 0
        setting.modeSort = userdefault.value(forKey: kSetting.settingModeSort.rawValue) as? Int ?? 0
        return setting
    }

}





