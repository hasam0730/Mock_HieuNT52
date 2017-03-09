//
//  EditProfileController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/7/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import Foundation
import  UIKit

extension EditProfileController {
    func save(infoImageAvatar: Dictionary<String, Any>) {
        if let infoImg = infoImageAvatar[UIImagePickerControllerOriginalImage], let infoImgUrl = infoImageAvatar[UIImagePickerControllerReferenceURL] {
            let image             = infoImg as? UIImage // get image in gallery
            let urlImg            = infoImgUrl as? NSURL // get url image in galerry
            let imageName         = urlImg?.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
            let photoURL          = NSURL(fileURLWithPath: documentDirectory)
            let localPath         = photoURL.appendingPathComponent(imageName!)
            let pathFile = "\(documentDirectory)/asset.JPG"
            print(localPath ?? "")
            if FileManager.default.fileExists(atPath: localPath!.path) {
                print("file already exists")
                self.deletingFileWith(path: pathFile)
                try! UIImageJPEGRepresentation(image!, 1.0)?.write(to: localPath!, options: .atomicWrite) // thuc hien copy image
            }
            else {
                do {
                    try UIImageJPEGRepresentation(image!, 1.0)?.write(to: localPath!, options: .atomicWrite) // thuc hien copy image
                    print("file saved")
                } catch {
                    print("error saving file")
                }
            }
            settingDataDefault(avatar: pathFile)
        }
        
    }
    
    func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func changeSex(sender: UISwitch) {
        sexTextField.text = sender.isOn ? "Male" : "Female"
    }
    
    func handlingPickerDate() {
        let date = dateOfBirthPicker.date
        let timeItv = date.timeIntervalSince1970
        settingDataDefault(dob: timeItv)
        let dateformatter = DateFormatter()
        dateformatter.dateStyle = .full
        dateformatter.locale = Locale.current
        let datestr = dateformatter.string(from: date)
        dateBirthTextField.resignFirstResponder()
        dateBirthTextField.text = datestr
    }
    
}
