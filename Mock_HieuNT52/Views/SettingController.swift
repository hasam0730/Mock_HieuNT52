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
    
    let labelTitles = ["Popular Movies", "Top Rated Movies", "Upcoming Movies", "NowPlaying Movies"]
    let headerTitles = ["Filter", "Sort by", "Number of loading"]
    private func setupViews() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 600
        navigationItem.title = "Setting"
        view.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
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
    
    func registerCellClass() {
        tableView.register(RowSettingLabel.self, forCellReuseIdentifier: cellIDLabel)
        tableView.register(RowSettingSlider.self, forCellReuseIdentifier: cellIDSlider)
        tableView.register(RowSettingLabelStepper.self, forCellReuseIdentifier: cellIDLabelStepper)
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section, indexPath.row) {
        case (0,0),(0,1),(0,2),(0,3),(1,0),(1,1):
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDLabel, for: indexPath) as! RowSettingLabel
            cell.content = labelTitles[indexPath.row]
            cell.tag = tagNumber
            tagNumber += 1
            if cell.tag == gettingDataSettingDefault().modeFilter {
               addingCheckmark(cell: cell, check: imgCheckFilter)
                print("tag filter user: \(gettingDataSettingDefault().modeFilter)")
            } else if cell.tag == gettingDataSettingDefault().modeSort {
               addingCheckmark(cell: cell, check: imgCheckSort)
                print("tag sort user: \(gettingDataSettingDefault().modeSort)")
            }
            return cell
        case (0,4):
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDSlider, for: indexPath) as! RowSettingSlider
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellIDLabelStepper, for: indexPath) as! RowSettingLabelStepper
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return headerTitles[section]
    }
    var cellFilter = UITableViewCell()
    var cellSort = UITableViewCell()
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if let cell = cell {
            if (cell.isKind(of: RowSettingLabel.self)) {
                if indexPath.section == 0 {
                    cellFilter = cell
                    settingDataDefault(settingModeFilter: cell.tag)
                    addingCheckmark(cell: cellFilter, check: imgCheckFilter)
                }
                if indexPath.section == 1 {
                    cellSort = cell
                    settingDataDefault(settingModeSort: cell.tag)
                    addingCheckmark(cell: cellSort, check: imgCheckSort)
                }
            }
        }
        var dic = [String: AnyObject]()
        let setting = UIViewController().gettingDataSettingDefault()
        dic[kSetting.settingModeFilter.rawValue] = setting.modeFilter as AnyObject
        dic[kSetting.settingModeSort.rawValue] = setting.modeSort as AnyObject
        dic[kSetting.settingRateMovie.rawValue] = setting.rateMovie as AnyObject
        dic[kSetting.settingReleaseYear.rawValue] = setting.releaseYear as AnyObject
        dic[kSetting.settingNumberLoadding.rawValue] = setting.numberLoad as AnyObject
        NotificationCenter.default.post(name: TOPRATED_NOTIFICATION, object: SettingController(), userInfo: dic)
    }
    
    func addingCheckmark(cell: UIView, check: UIImageView) {
        cell.addSubview(check)
        check.anchorCenterYToSuperview()
        check.anchor(nil, left: nil, bottom: nil, right: cell.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 10, widthConstant: 20, heightConstant: 20)
    }
    
    let imgCheckFilter: UIImageView = {
        let imgCheck = UIImageView()
        imgCheck.image = #imageLiteral(resourceName: "Checkmark")
        return imgCheck
    }()
    
    let imgCheckSort: UIImageView = {
        let imgCheck = UIImageView()
        imgCheck.image = #imageLiteral(resourceName: "Checkmark")
        return imgCheck
    }()
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        print(indexPath.row)
    }
}
