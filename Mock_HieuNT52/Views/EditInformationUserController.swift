//
//  EditInformationUserController.swift
//  Mock_HieuNT52
//
//  Created by Developer on 2/27/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit

class EditInformationUserController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    fileprivate func setUpViews() {
        view.backgroundColor = .white
        //
        view.addSubview(titleLabel)
        view.addSubview(saveButton)
        //
        titleLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        saveButton.frame = CGRect(x: 10, y: 10, width: 100, height: 30)
        
        //
        let saveAction = UITapGestureRecognizer(target: self, action: #selector(handleSave))
        saveButton.addGestureRecognizer(saveAction)
    }
    
    func handleSave() {
        dismiss(animated: true, completion: nil)
    }
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "nguyen trung hieu"
        label.backgroundColor = #colorLiteral(red: 0.3098039329, green: 0.01568627544, blue: 0.1294117719, alpha: 1)
        return label
    }()
    
    let saveButton: UIButton = {
       let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        return button
    }()
}
