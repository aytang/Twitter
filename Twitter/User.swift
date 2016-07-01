//
//  User.swift
//  Twitter
//
//  Created by Allison Tang on 6/27/16.
//  Copyright © 2016 Allison Tang. All rights reserved.
//

import UIKit

class User: NSObject {

    var name: String?
    var screenname: String?
    var profileUrl: String?
    var tagline: String?
    var dictionary: NSDictionary?
    var followingCount: Int?
    var tweetsCount: Int?
    var followersCount: Int?
    
    init(dictionary: NSDictionary) {
        self.dictionary = dictionary
        name = (dictionary["name"] as? String) ?? ""
        followingCount = (dictionary["friends_count"] as? Int) ?? 0
        tweetsCount = (dictionary["statuses_count"] as? Int) ?? 0
        screenname = dictionary["screen_name"] as? String
        followersCount = (dictionary["followers_count"] as? Int) ?? 0
        profileUrl = (dictionary["profile_image_url_https"] as? String) ?? ""
        /*
        if let profileUrlString = profileUrlString {
            profileUrl = NSURL(string: profileUrlString)
        }
 */
        tagline = dictionary["description"] as? String
        
    }
    static let userDidLogoutNotification = "UserDidLogout"
    
    static var _currentUser: User?
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
            let defaults = NSUserDefaults.standardUserDefaults()
            let userData = defaults.objectForKey("currentUserData") as? NSData
            if let userData = userData {
                let dictionary = try! NSJSONSerialization.JSONObjectWithData(userData, options: []) as! NSDictionary
                _currentUser = User(dictionary: dictionary)
                }}
            return _currentUser
        }
        
        set(user) {
            _currentUser = user 
            let defaults = NSUserDefaults.standardUserDefaults()
            if let user = user {
                let data = try! NSJSONSerialization.dataWithJSONObject(user.dictionary!, options: [])
                defaults.setObject(data, forKey: "currentUserData")
            } else {
                defaults.setObject(nil, forKey: "currentUserData")
            }
            defaults.synchronize()
                    }
    }
    
}
