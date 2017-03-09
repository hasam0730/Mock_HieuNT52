//
//  RowSettingSlider.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/9/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class RowSettingSlider: UITableViewCell {
    //
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupViews() {
        addSubview(label)
        addSubview(slider)
        addSubview(minimumLabel)
        addSubview(maximumLabel)
        addSubview(yearReleaseLabel)
        addSubview(stepper)
        stepper.addTarget(self, action: #selector(handlingStepperChangeValue(sender:)), for: .valueChanged)
        slider.addTarget(self, action: #selector(handlingSliderChangeValue(sender:)), for: .valueChanged)
        //
        addConstraintsWithFormat(format: "V:|-5-[v0(30)]", views: label)
        addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: label)
        //
        minimumLabel.anchor(label.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 40, heightConstant: 30)
        maximumLabel.anchor(label.bottomAnchor, left: nil, bottom: nil, right: self.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 0, rightConstant: 5, widthConstant: 40, heightConstant: 30)
        //
        slider.anchor(label.bottomAnchor, left: minimumLabel.rightAnchor, bottom: nil, right: maximumLabel.leftAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 30)
        //
        yearReleaseLabel.anchor(minimumLabel.bottomAnchor, left: self.leftAnchor, bottom: nil, right: nil, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant: 30)
        stepper.anchor(maximumLabel.bottomAnchor, left: nil, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 5, leftConstant: 0, bottomConstant: 5, rightConstant: 10, widthConstant: 95, heightConstant: 30)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    let label: UILabel = {
        let label = UILabel()
        let attributeText = NSMutableAttributedString(string: "Movie with rate from: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkText])
        let rateMovie = UIViewController().gettingDataSettingDefault().rateMovie
        if let ratemv = rateMovie {
            attributeText.append(NSAttributedString(string: "\(ratemv)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.darkGray]))
        }
        label.attributedText = attributeText
        return label
    }()
    
    let minimumLabel: UILabel = {
        let label = UILabel()
        label.text = "Min"
        return label
    }()
    
    let maximumLabel: UILabel = {
        let label = UILabel()
        label.text = "Max"
        return label
    }()
    
    let slider: UISlider = {
        let slider = UISlider()
        let rateMovie = UIViewController().gettingDataSettingDefault().rateMovie
        if let ratemv = rateMovie {
            slider.setValue(ratemv, animated: true)
        }
        slider.minimumValue = 0
        slider.maximumValue = 10.0
        return slider
    }()
    
    let yearReleaseLabel: UILabel = {
        let label = UILabel()
        let attributeText = NSMutableAttributedString(string: "From release year: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: .infinity)])
        attributeText.append(NSAttributedString(string: "1970", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15)]))
        label.attributedText = attributeText
        return label
    }()
    
    let stepper: UIStepper = {
        let stepper = UIStepper()
        let releaseYear = UIViewController().gettingDataSettingDefault().releaseYear
        stepper.stepValue = 1
        return stepper
    }()
    
    let step: Float = 0.5
    func handlingSliderChangeValue(sender: UISlider) {
        let roundedValue = round(sender.value / step) * step
        sender.value = roundedValue
        UIViewController().settingDataDefault(settingRateMovie: roundedValue)
        let attributeText = NSMutableAttributedString(string: "Movie with rate from: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray])
        attributeText.append(NSAttributedString(string: "\(sender.value)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.darkGray]))
        self.label.attributedText = attributeText
    }
    
    func handlingStepperChangeValue(sender: UIStepper) {
        UIViewController().settingDataDefault(settingReleaseYear: Int(sender.value))
        let attributeText = NSMutableAttributedString(string: "From release year: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray])
        attributeText.append(NSAttributedString(string: "\(Int(sender.value))", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.darkGray]))
        self.yearReleaseLabel.attributedText = attributeText
    }
}
