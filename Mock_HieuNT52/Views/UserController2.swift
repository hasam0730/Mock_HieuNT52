////
////  UserController.swift
////  Mock_HieuNT52
////
////  Created by Developer on 2/23/17.
////  Copyright © 2017 Developer. All rights reserved.
////
//
//import UIKit
//
//class UserController1: UIViewController {
//
//    @IBOutlet weak var imageAvatar: UIImageView!
//    @IBOutlet weak var personalInformationTxtView: UITextView!
//    @IBOutlet weak var reminderListTextView: UITextView!
//    @IBAction func editButton(_ sender: UIButton) {
//        
//    }
//    @IBAction func showAllButton(_ sender: UIButton) {
//        
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        self.setupViews()
//        //
//        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        print("view will appear")
//    }
//    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//        print("view did disapear")
//    }
//    
//    fileprivate func setupViews() {
//        // setup image avatar
//        imageAvatar.layer.cornerRadius = imageAvatar.frame.width/2
//        imageAvatar.layer.borderColor = UIColor.rgb(red: 189, green: 110, blue: 132).cgColor
//        imageAvatar.layer.borderWidth = 5.0
//        imageAvatar.clipsToBounds = true
//        
//        // setup personalInformationTxtView
//        personalInformationTxtView.isEditable = false
//        personalInformationTxtView.isScrollEnabled = false
//        let attributeTextPersonalInformation = NSMutableAttributedString(string: "Hasamkiyoshi", attributes: [NSFontAttributeName:UIFont.systemFont(ofSize: 16, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray])
//        attributeTextPersonalInformation.append(NSAttributedString(string: "\nDOB: 07/03/1993", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
//        attributeTextPersonalInformation.append(NSAttributedString(string: "\nEmail: Hasamkiyoshi@gmail.com", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
//        attributeTextPersonalInformation.append(NSAttributedString(string: "\nSex: Male", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 14)]))
//        personalInformationTxtView.attributedText = attributeTextPersonalInformation
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}
