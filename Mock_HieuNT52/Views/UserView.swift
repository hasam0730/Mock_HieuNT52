//
//  RearController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/23/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import CoreData

class UserController: UIViewController {
    
    
    //
    var headerMaskLayer:CAShapeLayer!
    
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
        updateUI()
    }
    
    func updateUI() {
        let user = gettingDataUserDefault()
        self.nameLabel.text = user.name
        self.imageAvatar.image = gettingImageAvatarByDocument()
        //
        let attributeText = NSMutableAttributedString()
        attributeText.append(NSAttributedString(string: "🎂DOB: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: 16)]))
        //
        attributeText.append(NSAttributedString(string: "\(castingTimeintervalToDateString(timeinterval: user.DOB!, formatter: "dd/mm/yyyy"))\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        //
        attributeText.append(NSAttributedString(string: "📨Email: : ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: 16)]))
        attributeText.append(NSAttributedString(string: "\(user.Email!)\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        //
        attributeText.append(NSAttributedString(string: "💑Sex: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: 16)]))
        let sexStr = (user.Sex!) ? "Male" : "Female"
        attributeText.append(NSAttributedString(string: sexStr, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        attributeText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributeText.string.characters.count))
        personelInformationTextView.attributedText = attributeText
        
    }
    
    fileprivate func setupViews() {
//        view.addObserver(self, forKeyPath: "center", options: [.new, .old], context: nil)
        //
        view.backgroundColor = UIColor.white
        view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        view.addSubview(headerView)
        view.addSubview(personelInformationTextView)
        //
        view.addSubview(editButton)
        view.addSubview(separatorLine)
        view.addSubview(reminderListTextView)
        //
        view.addSubview(showAllReminderButton)
        headerView.addSubview(imageAvatar)
        headerView.addSubview(nameLabel)
        //
        view.addConstraintsWithFormat(format: "V:|[v0(180)]", views: headerView)
        view.addConstraintsWithFormat(format: "H:|[v0]-55-|", views: headerView)
        //
        imageAvatar.anchorCenterXToSuperview()
        imageAvatar.anchor(headerView.topAnchor,
                           left: nil,
                           bottom: nil,
                           right: nil,
                           topConstant: 25,
                           leftConstant: 0,
                           bottomConstant: 0,
                           rightConstant: 0,
                           widthConstant: 120,
                           heightConstant: 120)
        //
        headerView.addConstraintsWithFormat(format: "V:[v0]-2-[v1(25)]", views: imageAvatar, nameLabel)
        headerView.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: nameLabel)
        //
        view.addConstraintsWithFormat(format: "V:[v0]-10-[v1(100)]", views: headerView, personelInformationTextView)
        view.addConstraintsWithFormat(format: "H:|-10-[v0]-10-|", views: personelInformationTextView)
        //
        editButton.anchor(personelInformationTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 70, widthConstant: 0, heightConstant: 40)
        //
        separatorLine.anchor(editButton.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 5, bottomConstant: 0, rightConstant: 65, widthConstant: 0, heightConstant: 0.5)
        //
        reminderListTextView.anchor(separatorLine.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 5, leftConstant: 10, bottomConstant: 0, rightConstant: 10, widthConstant: 0, heightConstant: 160)
        //
        showAllReminderButton.anchor(reminderListTextView.bottomAnchor, left: view.leftAnchor, bottom: nil, right: view.rightAnchor, topConstant: 10, leftConstant: 10, bottomConstant: 0, rightConstant: 70, widthConstant: 0, heightConstant: 40)
    }
    
    let headerView: UIView = {
        let view = UIView()
        view.backgroundColor = headerColor
        return view
    }()
    
    let imageAvatar: UIImageView = {
        let imgView = UIImageView()
        imgView.contentMode = .scaleToFill
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
        button.layer.cornerRadius = 5
        return button
    }()
    
    let personelInformationTextView: UITextView = {
        let textView = UITextView()
        textView.isSelectable = false
        textView.isEditable = false
        //
        let attributeText = NSMutableAttributedString()
        attributeText.append(NSAttributedString(string: "🎂DOB: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: 16)]))
        attributeText.append(NSAttributedString(string: "07/03/1993\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        //
        attributeText.append(NSAttributedString(string: "📨Email: : ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: 16)]))
        attributeText.append(NSAttributedString(string: "hasam@gmail.com\n", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        //
        attributeText.append(NSAttributedString(string: "💑Sex: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: 16)]))
        attributeText.append(NSAttributedString(string: "Male", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 12
        attributeText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributeText.string.characters.count))
        textView.attributedText = attributeText
        textView.textColor = UIColor.darkGray
        //
        return textView
    }()
    
    let reminderListTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isSelectable = false
        textView.isScrollEnabled = false
        let attributeText = NSMutableAttributedString(string: "⏰Reminder List: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: .infinity)])
        //
        let arrReminderMovies = CoreDataHandler.shareInstance.allRecords(ReminderMovies.self)
        let countItem = (arrReminderMovies.count>2) ? 2 : arrReminderMovies.count
        for index in 0..<countItem {
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .full
            dateformatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            dateformatter.locale = Locale.current
            let convertTimeintervalToDate = NSDate(timeIntervalSince1970: TimeInterval(arrReminderMovies[index].time_reminder)) as Date
            let dateString = dateformatter.string(from: convertTimeintervalToDate as Date)
            attributeText.append(NSAttributedString(string: "\n‣ \(arrReminderMovies[index].title!) - ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: .infinity)]))
            attributeText.append(NSAttributedString(string:"\(arrReminderMovies[index].vote_average)/10\n\(dateString)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 16)]))
        }
        //
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 6
        attributeText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributeText.string.characters.count))
        //
        textView.attributedText = attributeText
        return textView
    }()
    
    let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.addingShadowTo(view: view)
        return view
    }()
    
    let showAllReminderButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Show All", for: .normal)
        button.addTarget(self, action: #selector(showall), for: .touchUpInside)
        button.backgroundColor = UIColor.rgb(red: 234, green: 162, blue: 139)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .infinity)
        button.layer.cornerRadius = 5
        return button
    }()
    
    func edit() {
        self.present(EditProfileController(), animated: true)
    }
    
    func showall() {
        self.present(ReminderMovieController(), animated: true)
    }
}
