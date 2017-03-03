//
//  RearController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/23/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class UserController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewWillDisappear")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("viewWillAppear")
        view.reloadInputViews()
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        print(self.view.frame.width)
    }
    
    fileprivate func setupViews() {
        view.addObserver(self, forKeyPath: "center", options: [.new, .old], context: nil)
        //
        view.backgroundColor = UIColor.white
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.addSubview(viewBackground)
        view.addSubview(personelInformationTextView)
        view.addSubview(editButton)
        view.addSubview(reminderListTextView)
        viewBackground.addSubview(imageAvatar)
        viewBackground.addSubview(nameLabel)
        //
        let screenWidth = view.frame.width - 55
        viewBackground.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 200)
        nameLabel.frame = CGRect(x: 0, y: viewBackground.frame.height - 55, width: screenWidth, height: 30)
        imageAvatar.frame = CGRect(x: (screenWidth-100)/2, y: 35, width: 100, height: 100)
        personelInformationTextView.frame = CGRect(x: 10, y: viewBackground.frame.height + 15, width: 300, height: 100)
        editButton.frame = CGRect(x: (screenWidth-100)/2, y: 320, width: 100, height: 40)
        reminderListTextView.frame = CGRect(x: 10, y: editButton.frame.origin.y + 60, width: 300, height: 100)
        //
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapAvatar))
        imageAvatar.isUserInteractionEnabled = true
        imageAvatar.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func myContext() {
        
    }
    
    func handleTapAvatar() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary;
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        dismiss(animated: true, completion: {
            self.imageAvatar.image = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.imageAvatar.contentMode = .scaleToFill
        })
    }
    
    let viewBackground: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.rgb(red: 126, green: 107, blue: 142)
        return view
    }()
    
    let imageAvatar: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleAspectFit        
        imgView.layer.borderWidth = 5
        imgView.layer.borderColor = UIColor.white.cgColor
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.image = UIImage(named: "avatar")
        //
        return imgView
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "nguyen trung hieu"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .infinity)
        label.textColor = UIColor.white
        return label
    }()
    
    let editButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Edit", for: .normal)
        button.addTarget(self, action: #selector(edit), for: .touchUpInside)
        button.backgroundColor = UIColor.rgb(red: 234, green: 162, blue: 139)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .infinity)
        button.layer.cornerRadius = 10
        return button
    }()
    
    let personelInformationTextView: UITextView = {
        let textView = UITextView()
        //
        let attachment_dob = NSTextAttachment()
        attachment_dob.image = #imageLiteral(resourceName: "globe_icon")
        attachment_dob.bounds = CGRect(x: 0, y: -1, width: 12, height: 12)
        let attributeText = NSMutableAttributedString()
        attributeText.append(NSAttributedString(attachment: attachment_dob))
        //
        attributeText.append(NSAttributedString(string: "DOB: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: 16)]))
        attributeText.append(NSAttributedString(string: "07/03/1993\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        //
        let attachment_email = NSTextAttachment()
        attachment_email.image = #imageLiteral(resourceName: "globe_icon")
        attachment_email.bounds = CGRect(x: 0, y: -1, width: 12, height: 12)
        attributeText.append(NSAttributedString(attachment: attachment_email))
        //
        attributeText.append(NSAttributedString(string: "Email: : ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: 16)]))
        attributeText.append(NSAttributedString(string: "hasam@gmail.com\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        //
        let attachment_sex = NSTextAttachment()
        attachment_sex.image = #imageLiteral(resourceName: "globe_icon")
        attachment_sex.bounds = CGRect(x: 0, y: -1, width: 12, height: 12)
        attributeText.append(NSAttributedString(attachment: attachment_sex))
        //
        attributeText.append(NSAttributedString(string: "Sex: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: 16)]))
        attributeText.append(NSAttributedString(string: "Male", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributeText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributeText.string.characters.count))
        //
        textView.attributedText = attributeText
        textView.textColor = UIColor.darkGray
        //
        return textView
    }()
    
    let reminderListTextView: UITextView = {
        let textView = UITextView()
        let attributeText = NSMutableAttributedString(string: "Reminder List: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: .infinity)])
        //
        attributeText.append(NSAttributedString(string: "\nCuoi ngay keo lo - 10/10\n2016/09/10 13:20", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        //
        textView.attributedText = attributeText
        return textView
    }()
    
    func edit() {
        present(EditInformationUserController(), animated: true, completion: nil)
    }
}
