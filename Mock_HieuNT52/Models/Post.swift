//
//  File.swift
//  exampleSwift
//
//  Created by Developer on 2/13/17.
//  Copyright © 2017 Developer. All rights reserved.
//

import UIKit
//MARK: Model
class Post: SafeJsonObject {
    var name: String?
    var statusText: String?
    var profileImageName: String?
    var statusImageName: String?
    var numLikes: Int?
    var numComments: Int?
    var statusImageUrl: String?
    var location: Location?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "location" {
            location = Location()
            location?.setValuesForKeys(value as! [String: AnyObject])
        } else {
            super.setValue(value, forKey: key)
        }
    }
}

class Location: NSObject {
    var city: String?
    var state: String?
}

class SafeJsonObject: NSObject {
    
    override func setValue(_ value: Any?, forKey key: String) {
        let selectorString = "set\(key.uppercased().characters.first!)\(String(key.characters.dropFirst())):"
        let selector = Selector(selectorString)
        if responds(to: selector) {
            super.setValue(value, forKey: key)
        }
    }
}


class Posts {
    private var postsList = [Post]()
    init() {
        // 1
        let postMark = Post()
        postMark.name = "Mark Zuckerberg"
        postMark.statusText = "By giving people the power to share, we're making the world more transparent."
        postMark.profileImageName = "zuckprofile"
        postMark.numLikes = 400
        postMark.numComments = 123
        postMark.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/mark_zuckerberg_background.jpg"
        
        // 2
        let postSteve = Post()
        postSteve.name = "Steve Jobs"
        postSteve.statusText = "Desing is not just what it looks like and feels like. Desing is how it works.\n\n"
            + "Being the richest man in the cemetery doesn't matter to me. Going to bed at night saying"
            + "we've done something wonderful, that's what matters to me.\n\n"
            + "Sometimes when you innovate, you make mistakes. It is best to admit them quickly, and"
            + " get on with improving your other innovations."
        postSteve.profileImageName = "steve_profile"
        postSteve.numLikes = 1000
        postSteve.numComments = 55
        postSteve.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/steve_jobs_background.jpg"
        
        // 3
        let postGandhi = Post()
        postGandhi.name = "Mahatma Gandhi"
        postGandhi.profileImageName = "gandhi_profile"
        postGandhi.statusText = "Live as if you were to die tomorrow; learn as if you were to live forever.\n"
            + "The weak can never forgive. Forgiveness is the attribute of the strong.\n"
            + "Happiness is when what you think, what you say, and what you do are in harmony."
        postGandhi.numLikes = 333
        postGandhi.numComments = 22
        postGandhi.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gandhi_status.jpg"
        
        // 4
        let postBillGates = Post()
        postBillGates.name = "Bill Gates"
        //        postBillGates.profileImageName = "avatar_placeholder"
        postBillGates.statusText = "Success is a lousy teacher. It seduces smart people into thinking they can't lose.\n\n" +
            "Your most unhappy customers are your greatest source of learning.\n\n" +
        "As we look ahead into the next century, leaders will be those who empower others."
        postBillGates.numLikes = 333
        postBillGates.numComments = 22
        postBillGates.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/gates_background.jpg"
        
        // 5
        let postTimCook = Post()
        postTimCook.name = "Tim Cook"
        //        postTimCook.profileImageName = "avatar_placeholder"
        postTimCook.statusText = "The worst thing in the world that can happen to you if you're an engineer that has given his life to something is for someone to rip it off and put their name on it."
        postTimCook.numLikes = 333
        postTimCook.numComments = 22
        postTimCook.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/Tim+Cook.png"
        
        // 6
        let postDonaldTrump = Post()
        postDonaldTrump.name = "Donald Trump"
        //        postDonaldTrump.profileImageName = "avatar_placeholder"
        postDonaldTrump.statusText = "An ‘extremely credible source’ has called my office and " +
        "told me that Barack Obama’s birth certificate is a fraud."
        postDonaldTrump.numLikes = 333
        postDonaldTrump.numComments = 22
        postDonaldTrump.statusImageUrl = "https://s3-us-west-2.amazonaws.com/letsbuildthatapp/trump_background.jpg"
        
//        postsList = [postMark, postSteve, postGandhi, postBillGates, postTimCook, postDonaldTrump]
    }
    
    func numberOfPosts() -> Int {
        return postsList.count
    }
    
    subscript(indexPath: NSIndexPath) -> Post {
        get {
            return postsList[indexPath.item]
        }
    }
}

