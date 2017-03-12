//
//  File1.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/21/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
let cellIDLabel = "cellIdLabel"
let cellIDSlider = "cellIdSlider"
let cellIDLabelStepper = "cellIdLabelStepper"

class SettingController: UITableViewController {
    //
    var tagNumber = 1
    var cellFilter = UITableViewCell()
    var cellSort = UITableViewCell()
    let labelTitles = ["Popular Movies", "Top Rated Movies", "Upcoming Movies", "NowPlaying Movies"]
    let labelSortBy = ["Popula Movies", "Top Rate Movies"]
    let headerTitles = ["Filter", "Sort by", "Number of loading"]
    var arrCheckmark = [UIImageView]()
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        registerCellClass()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tagNumber = 1
    }
    
    private func setupViews() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
        navigationItem.title = "Setting"
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    func registerCellClass() {
        tableView.register(RowSettingLabel.self, forCellReuseIdentifier: cellIDLabel)
        tableView.register(RowSettingSlider.self, forCellReuseIdentifier: cellIDSlider)
        tableView.register(RowSettingLabelStepper.self, forCellReuseIdentifier: cellIDLabelStepper)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
            case 0: return 5
            case 1: return 2
            default: return 1
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0),(0,1),(0,2),(0,3),(1,0),(1,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDLabel, for: indexPath) as! RowSettingLabel
            if indexPath.section == 0 {
                cell.content = labelTitles[indexPath.row]
            } else if indexPath.section == 1 {
                cell.content = labelSortBy[indexPath.row]
            }
            if cell.content ==  labelTitles[gettingDataSettingDefault().modeFilter!] && indexPath.section == 0 {
                creatingCheckmark()
                addingCheckmark(cell: cell, check: arrCheckmark[indexPath.section])
            } else if cell.content == labelSortBy[gettingDataSettingDefault().modeSort!] && indexPath.section == 1 {
                creatingCheckmark()
                addingCheckmark(cell: cell, check: arrCheckmark[indexPath.section])
            }
            return cell
        case (0,4):
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDSlider, for: indexPath) as! RowSettingSlider
            return cell
        case (2,0):
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDLabelStepper, for: indexPath) as! RowSettingLabelStepper
            return cell
        default:
            tagNumber = 1
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let cell = cell {
            if (cell.isKind(of: RowSettingLabel.self)) {
                if indexPath.section == 0 {
                    cellFilter = cell
                    settingDataDefault(settingModeFilter: indexPath.row)
                    addingCheckmark(cell: cellFilter, check: arrCheckmark[indexPath.section])
                }
                if indexPath.section == 1 {
                    cellSort = cell
                    settingDataDefault(settingModeSort: indexPath.row)
                    addingCheckmark(cell: cellSort, check: arrCheckmark[indexPath.section])
                }
            }
        }
        //
//        var dic = [String: AnyObject]()
//        let setting = UIViewController().gettingDataSettingDefault()
//        dic[kSetting.settingModeFilter.rawValue] = setting.modeFilter as AnyObject
//        dic[kSetting.settingModeSort.rawValue] = setting.modeSort as AnyObject
//        dic[kSetting.settingRateMovie.rawValue] = setting.rateMovie as AnyObject
//        dic[kSetting.settingReleaseYear.rawValue] = setting.releaseYear as AnyObject
//        dic[kSetting.settingNumberLoadding.rawValue] = setting.numberLoad as AnyObject
        //
//        NotificationCenter.default.post(name: FILTER_NOTIFICATION, object: SettingController(), userInfo: dic)
        NotificationCenter.default.post(name: FILTER_NOTIFICATION, object: SettingController(), userInfo: nil)
    }
    
    func addingCheckmark(cell: UIView, check: UIImageView) {
        cell.addSubview(check)
        check.anchorCenterYToSuperview()
        check.anchor(nil, left: nil, bottom: nil, right: cell.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 20, heightConstant: 20)
    }
    
    func creatingCheckmark() {
        let imgCheck = UIImageView()
        imgCheck.image = #imageLiteral(resourceName: "Checkmark")
        arrCheckmark.append(imgCheck)
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
