//
//  EditInformationUserController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/27/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
var infoImageAvatar = Dictionary<String, Any>()
class EditProfileController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
        updateUI()
    }
    
    fileprivate func updateUI() {
        let user = gettingDataUserDefault()
        emailTextField.text = user.Email
        dateBirthTextField.text = castingTimeintervalToDateString(timeinterval: user.DOB!, formatter: "dd/mm/yyyy")
        self.imageAvatar.image = gettingImageAvatarByDocument()
    }
    
    fileprivate func setUpViews() {
        //
        self.hideKeyboardWhenTappedAround()
        //
        view.backgroundColor = .white
        //
        view.addSubview(headerView)
        headerView.addSubview(saveButton)
        headerView.addSubview(cancelButton)
        headerView.addSubview(imageAvatar)
        headerView.addSubview(nameLabel)
        view.addSubview(dateBirthTextField)
        view.addSubview(emailTextField)
        view.addSubview(sexTextField)
        view.addSubview(sexSwitch)
        //
        //
        dateBirthTextField.inputView = dateOfBirthPicker
        //
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 360, height: 44))
        toolbar.tintColor = .red
        let doneItem = UIBarButtonItem(title: "Close", style: .done, target: self, action: #selector(handlingPickerDate))
        let space: UIBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        toolbar.setItems([doneItem, space], animated: true)
        dateBirthTextField.inputAccessoryView = toolbar
        //
        headerView.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 250)
        self.headerView.addConstraintsWithFormat(format: "V:|-25-[v0(30)]", views: self.cancelButton)
        self.headerView.addConstraintsWithFormat(format: "H:|-15-[v0(30)]", views: self.cancelButton)
        //
        headerView.addConstraintsWithFormat(format: "V:|-25-[v0(44)]", views: self.saveButton)
        headerView.addConstraintsWithFormat(format: "H:[v0(44)]-15-|", views: self.saveButton)
        //
        imageAvatar.anchorCenterXToSuperview()
        imageAvatar.anchor(headerView.topAnchor,
                           left: nil,
                           bottom: nil,
                           right: nil,
                           topConstant: 50,
                           leftConstant: 0,
                           bottomConstant: 0,
                           rightConstant: 0,
                           widthConstant: 140,
                           heightConstant: 140)
        //
        nameLabel.anchorCenterXToSuperview()
        nameLabel.anchor(imageAvatar.bottomAnchor,
                         left: nil,
                         bottom: nil,
                         right: nil,
                         topConstant: 10,
                         leftConstant: 0,
                         bottomConstant: 0,
                         rightConstant: 0,
                         widthConstant: headerView.frame.width,
                         heightConstant: 30)
        //
        dateBirthTextField.anchor(headerView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 35)
        //
        emailTextField.anchor(dateBirthTextField.bottomAnchor, left: dateBirthTextField.leftAnchor, bottom: nil, right: dateBirthTextField.rightAnchor, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 35)
        //
        sexTextField.anchor(emailTextField.bottomAnchor, left: dateBirthTextField.leftAnchor, bottom: nil, right: nil, topConstant: 10, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 200, heightConstant:35)
        //
        sexSwitch.anchor(sexTextField.topAnchor, left: nil, bottom: nil, right: dateBirthTextField.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 100, heightConstant: 35)
        //
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAvatar))
        imageAvatar.isUserInteractionEnabled = true
        imageAvatar.addGestureRecognizer(tapGestureRecognizer)
    }
    
    // handle event when tap avatar
    func handleTapAvatar() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func handleSave() {
        dismiss(animated: true, completion: nil)
    }
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "bg_profile"))
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "nguyen trung hieu"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .infinity)
        label.textColor = UIColor.white
        return label
    }()
    
    let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Save").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlingSave), for: .touchUpInside)
        return button
    }()
    
    let cancelButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Back").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(cancel), for: .touchUpInside)
        return button
    }()
    
    let imageAvatar: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
        imgView.layer.borderWidth = 5
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        imgView.image = UIImage(named: "avatar")
        //
        return imgView
    }()
    
    let dateBirthTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.borderStyle = UITextBorderStyle.roundedRect
        textfield.placeholder = "Date of birth ..."
        //
        return textfield
    }()
    
    let dateOfBirthPicker: UIDatePicker = {
        let datepicker = UIDatePicker()
        datepicker.datePickerMode = .date
        return datepicker
    }()
    
    let emailTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.borderStyle = UITextBorderStyle.roundedRect
        textfield.placeholder = "Email ..."
        textfield.keyboardType = .emailAddress
        return textfield
    }()
    
    let sexTextField: UITextField = {
        let textfield = UITextField()
        textfield.layer.borderColor = UIColor.black.cgColor
        textfield.borderStyle = UITextBorderStyle.roundedRect
        textfield.text = "Male"
        textfield.isEnabled = false
        return textfield
    }()
    
    let sexSwitch: UISwitch = {
        let switchsex = UISwitch()
        switchsex.addTarget(self, action: #selector(changeSex), for: .valueChanged)
        return switchsex
    }()
    
    func handlingSave(sender: UIButton) {
        self.save(infoImageAvatar: infoImageAvatar)
        settingDataUserDefault(email: emailTextField.text, name: nameLabel.text, sex: sexSwitch.isOn)
        updateUI()
    }
}

extension EditProfileController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    // handle event after picking image (delegate)
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: {
            infoImageAvatar = info
            self.imageAvatar.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.imageAvatar.contentMode = .scaleToFill
//            let image             = info[UIImagePickerControllerOriginalImage] as? UIImage // get image in gallery
//            let urlImg            = info[UIImagePickerControllerReferenceURL] as? NSURL // get url image in galerry
//            let imageName         = urlImg?.lastPathComponent
//            let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
//            let photoURL          = NSURL(fileURLWithPath: documentDirectory)
//            let localPath         = photoURL.appendingPathComponent(imageName!)
//            print(localPath ?? "")
//            if FileManager.default.fileExists(atPath: localPath!.path) {
//                print("file already exists")
//                self.deletingFileWith(path: "\(documentDirectory)/asset.JPG")
//                try! UIImageJPEGRepresentation(image!, 1.0)?.write(to: localPath!, options: .atomicWrite) // thuc hien copy image
//            }
//            else {
//                do {
//                    try UIImageJPEGRepresentation(image!, 1.0)?.write(to: localPath!, options: .atomicWrite) // thuc hien copy image
//                    print("file saved")
//                } catch {
//                    print("error saving file")
//                }
//            }
        })
    }
}

