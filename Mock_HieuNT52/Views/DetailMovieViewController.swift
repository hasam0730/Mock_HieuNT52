//
//  DetailMovieViewController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 3/1/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
import UserNotifications

class DetailMovieViewController: UIViewController {
    var xCoordinate = 0
    var movie = Movie()
    var idMovie: Int? {
        didSet {
            guard let idmv = idMovie else { return }
            // release and rate textView
            let datahandler = DataHandler()
            datahandler.gettingMovieDetailByIdMovie(idMovie: idmv, completion: { [weak self] (data: Movie) in
                guard let strSelf = self else { return }
                strSelf.movie = data
                DispatchQueue.main.async {
                    strSelf.navigationItem.title = data.title
                    // release and rate textView
                    let attributeText = NSMutableAttributedString(string: "📽Release Date: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray])
                    attributeText.append(NSAttributedString(string: data.release_date!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13), NSForegroundColorAttributeName: UIColor.darkText]))
                    attributeText.append(NSAttributedString(string: "\n❤️Rating: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray]))
                    attributeText.append(NSAttributedString(string: "\(data.vote_average!)/10", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13), NSForegroundColorAttributeName: UIColor.darkText]))
                    //
                    let paragraphStyle = NSMutableParagraphStyle()
                    paragraphStyle.lineSpacing = 4
                    attributeText.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSMakeRange(0, attributeText.string.characters.count))
                    //
                    strSelf.releaseRateTextView.attributedText = attributeText
                    
                    // image poster
                    DispatchQueue.global().async {
                        let str = "\(urlImage)\(kPosterSize.w500.rawValue)\(data.poster_path!)"
                        let data = try? Data(contentsOf: URL(string: str)!)
                        DispatchQueue.main.async {
                            if let dataImg = data {
                                strSelf.imgPoster.image = UIImage(data: dataImg)
                            }
                        }
                    }
                    // overview
                    let attributeTextOverview = NSMutableAttributedString(string: "📄Overview: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: .infinity)])
                    attributeTextOverview.append(NSAttributedString(string: "\n\(data.overview!)", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 13), NSForegroundColorAttributeName: UIColor.darkGray]))
                    self?.overviewTextView.attributedText = attributeTextOverview
                    // time textView
                    let attributeTextTime = NSMutableAttributedString(string: "⏰Time: ", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: .infinity)])
                    attributeTextTime.append(NSAttributedString(string: "\n🤵Cast & Crew", attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15, weight: .infinity), NSForegroundColorAttributeName: UIColor.darkGray]))
                    //
                    let paraStyle = NSMutableParagraphStyle()
                    paraStyle.lineSpacing = 4
                    attributeTextTime.addAttribute(NSParagraphStyleAttributeName, value: paraStyle, range: NSMakeRange(0, attributeTextTime.string.characters.count))
                    //
                    strSelf.timeTextView.attributedText = attributeTextTime
                    
                    // castlist
                    DataHandler.shared.gettingCastList(idMovie: idmv, completion: { (data: [Cast]) in
                        for i in 0 ..< data.count {
                            let currCast = data[i]
                            DispatchQueue.global().async {
                                let data = try? Data(contentsOf: URL(string: "\(urlImage)\(kProfileSize.w185.rawValue)\(currCast.profile_path!)")!)
                                if let dataImg = data  {
                                    DispatchQueue.main.async {
                                        strSelf.castImageView = UIImageView()
                                        strSelf.nameCastLabel = UILabel()
                                        //
                                        let attrText = NSAttributedString(string: currCast.name!, attributes: [NSFontAttributeName: UIFont.systemFont(ofSize: 15), NSForegroundColorAttributeName: UIColor.darkGray])
                                        strSelf.castImageView.image = UIImage(data: dataImg)
                                        strSelf.nameCastLabel.attributedText = attrText
                                        strSelf.nameCastLabel.textAlignment = .center
                                        //
                                        strSelf.listCastScrollView.addSubview(strSelf.castImageView)
                                        strSelf.listCastScrollView.addSubview(strSelf.nameCastLabel)
                                        //
                                        if typeIphone == sizeIPhone.IPhone7 {
                                            strSelf.castImageView.frame = CGRect(x: strSelf.xCoordinate, y: 0, width: 150, height: 220)
                                            if i == (data?.count)!-1 {
                                                self?.xCoordinate += 150
                                            } else {
                                                self?.xCoordinate += 160
                                            }
                                        } else if typeIphone == sizeIPhone.IPhoneSE {
                                            strSelf.castImageView.frame = CGRect(x: strSelf.xCoordinate, y: 0, width: 100, height: 140)
                                            if i == (data?.count)!-1 {
                                                self?.xCoordinate += 100
                                            } else {
                                                self?.xCoordinate += 110
                                            }
                                        }
                                        strSelf.nameCastLabel.frame = CGRect(x: strSelf.castImageView.frame.origin.x, y: strSelf.castImageView.frame.size.height, width: strSelf.castImageView.frame.width, height: 30)
                                        //
                                        
                                        strSelf.listCastScrollView.contentSize = CGSize(width: strSelf.xCoordinate-10, height: 140)
                                    }
                                }
                            }
                        }
                    })
                }
            })
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUpViews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpViews() {
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        view.addSubview(mainScrollView)
        view.addSubview(releaseRateTextView)
        view.addSubview(imgPoster)
        view.addSubview(reminderButton)
        view.addSubview(timeTextView)
        view.addSubview(listCastScrollView)
        view.addSubview(overviewTextView)
        view.addSubview(favButton)
        //
//        self.view.addConstraintsWithFormat(format: "V:|[v0]|", views: mainScrollView)
//        self.view.addConstraintsWithFormat(format: "H:|[v0]|", views: mainScrollView)
        //
        self.view.addConstraintsWithFormat(format: "V:|-0-[v0(52)]-0-[v1(160)]-5-[v2(30)]-0-[v3(58)]-0-[v4]-0-|", views: releaseRateTextView, imgPoster, reminderButton, timeTextView, listCastScrollView)
        self.view.addConstraintsWithFormat(format: "V:|-0-[v0]-0-[v1(195)]-0-[v2]", views: releaseRateTextView, overviewTextView, timeTextView)
        self.view.addConstraintsWithFormat(format: "V:|-0-[v0(52)]", views: favButton)
        self.view.addConstraintsWithFormat(format: "H:|-5-[v0(52)]-5-[v1]-5-|", views: favButton, releaseRateTextView)
        self.view.addConstraintsWithFormat(format: "H:|-5-[v0(140)]-5-[v1]-5-|", views: imgPoster, overviewTextView)
        self.view.addConstraintsWithFormat(format: "H:|-5-[v0(140)]", views: reminderButton)
        self.view.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: timeTextView)
        self.view.addConstraintsWithFormat(format: "H:|-5-[v0]-5-|", views: listCastScrollView)
        //
        
    }
    
    let mainScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.scrollsToTop = true
        return scrollView
    }()
    
    let releaseRateTextView: UITextView = {
        let textView = UITextView()
        textView.text = "title"
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let imgPoster: UIImageView = {
        let imageView = UIImageView()
        imageView.image = #imageLiteral(resourceName: "zuckdog")
        //
        imageView.layer.shadowOffset = .zero
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowRadius = 4
        imageView.layer.shadowOpacity = 0.5
        imageView.layer.masksToBounds = false
        imageView.layer.shouldRasterize = true
        //
        return imageView
    }()
    
    let reminderButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("⏰Reminder", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = headerColor
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(handlingTapReminderButton), for: .touchUpInside)
        return button
    }()
    
    let overviewTextView: UITextView = {
        let textView = UITextView()
        textView.text = "overview"
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let timeTextView: UITextView = {
        let textView = UITextView()
        textView.isEditable = false
        textView.isScrollEnabled = false
        return textView
    }()
    
    let listCastScrollView: UIScrollView = {
       let scrollView = UIScrollView()
        return scrollView
    }()
    
    let favButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "Love").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handlingTapFavoriteButton), for: .touchUpInside)
        return button
    }()
    
    var castImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    var nameCastLabel: UILabel = {
       let label = UILabel()
        return label
    }()
    
//    func dateSelected() {
//        
//    }
    
    //MARK: handle action
    func handlingTapReminderButton() {
        // 1.
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 260))
        datePicker.datePickerMode = UIDatePickerMode.dateAndTime
        // add target
//        datePicker.addTarget(self, action: #selector(dateSelected), for: UIControlEvents.valueChanged)
        //
        let alertController = UIAlertController(title: "", message:" " , preferredStyle: UIAlertControllerStyle.actionSheet)
        alertController.view.addSubview(datePicker)//add subview
        //
        let doneAction = UIAlertAction(title: "Done", style: .cancel) { (action) in
            // convert date to type int from datePicker
            let dateformatter = DateFormatter()
            dateformatter.dateStyle = .full
            dateformatter.dateFormat = "dd-MM-yyyy HH:mm:ss"
            dateformatter.locale = Locale.current
            let intdate = datePicker.date.timeIntervalSince1970
            print("date type int: \(intdate)") // print date type int
            // convert int to date
            let convertIntToDate = NSDate(timeIntervalSince1970: intdate)
            let date = dateformatter.string(from: convertIntToDate as Date)
            print("full format date: \(date)")
            // getting time components
            let calendar = NSCalendar.current
            let hour = calendar.component(.hour, from: datePicker.date)
            let minute = calendar.component(.minute, from: datePicker.date)
            let second = calendar.component(.second, from: datePicker.date)
            let day = calendar.component(.day, from: datePicker.date)
            let month = calendar.component(.month, from: datePicker.date)
            // get time components
            var dateComponents = DateComponents()
            dateComponents.hour = hour
            dateComponents.minute = minute
            dateComponents.second = second
            dateComponents.day = day
            dateComponents.month = month
            print("date component: \(hour):\(minute):\(second)-\(day)/\(month)")
            // define notification
            let content = UNMutableNotificationContent()
            content.title = NSString.localizedUserNotificationString(forKey: "Elon said:", arguments: nil)
            content.body = NSString.localizedUserNotificationString(forKey: "Hello Tom！Get up, let's play with Jerry!", arguments: nil)
            content.sound = UNNotificationSound.default()
            content.badge = (UIApplication.shared.applicationIconBadgeNumber + 1) as NSNumber
            content.categoryIdentifier = "com.Hieunt52.mockProject"
            //
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            let uuid = NSUUID().uuidString.lowercased()
            let request = UNNotificationRequest(identifier: uuid, content: content, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request)
            //
            self.addingReminder(movie: self.movie, time_reminder: Int(intdate))
        }
        //
        alertController.addAction(doneAction)
        let height:NSLayoutConstraint = NSLayoutConstraint(item: alertController.view, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: 300)
        alertController.view.addConstraint(height);
        
        self.present(alertController, animated: true, completion: nil)
    }
 
    func handlingTapFavoriteButton() {
        addingFavorite(movie: movie)
    }

}
