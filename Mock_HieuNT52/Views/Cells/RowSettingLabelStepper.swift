//
//  RowSettingLabelStepper.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/9/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class RowSettingLabelStepper: UITableViewCell {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(label)
        addSubview(stepper)
        stepper.addTarget(self, action: #selector(handlingStepperChangeValue(sender:)), for: .valueChanged)
        //
        self.addConstraintsWithFormat(format: "V:|-5-[v0(30)]", views: label)
        self.addConstraintsWithFormat(format: "H:|-10-[v0(260)]", views: label)
        //
        self.addConstraintsWithFormat(format: "V:|-5-[v0(30)]", views: stepper)
        self.addConstraintsWithFormat(format: "H:[v0(95)]-10-|", views: stepper)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    let label: UILabel = {
        let label = UILabel()
        let attributeText = NSMutableAttributedString(string: "Number of page: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray])
        let currValue = UIViewController().gettingDataSettingDefault().numberLoad
        if let currvalue = currValue {
            attributeText.append(NSAttributedString(string: "\(currvalue)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]))
        }
        label.attributedText = attributeText
        return label
    }()
    
    let stepper: UIStepper = {
        let stepper = UIStepper()
        let currValue = UIViewController().gettingDataSettingDefault().numberLoad
        if let currvl = currValue {
            stepper.value = Double(currvl)
        }
        stepper.stepValue = 1
        return stepper
    }()
    
    func handlingStepperChangeValue(sender: UIStepper) {
        // update UI after changing value sender
        UIViewController().settingDataDefault(settingNumberLoadding: Int(sender.value))
        let attributeText = NSMutableAttributedString(string: "Number of page: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray])
        attributeText.append(NSAttributedString(string: "\(Int(sender.value))", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.darkGray]))
        self.label.attributedText = attributeText
        // post notification to update movie list
        NotificationCenter.default.post(name: FILTER_NOTIFICATION, object: SettingController(), userInfo: nil)
    }
}
