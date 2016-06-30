//
//  Tweet.swift
//  Twitter
//
//  Created by Allison Tang on 6/27/16.
//  Copyright © 2016 Allison Tang. All rights reserved.
//

import UIKit
import Foundation

class Tweet: NSObject {
    var text: String?
    var timestamp: NSDate?
    var retweetCount: Int = 0
    var favoritesCount: Int = 0
    var user: NSDictionary
    var username: String?
    var picUrl: String!
    var tweetID: String!
    var userID: String!
    
    init(dictionary: NSDictionary) {
        text = dictionary["text"] as? String
        retweetCount = (dictionary["retweet_count"]  as? Int) ?? 0
        user = (dictionary["user"] as? NSDictionary)!
        favoritesCount = (dictionary["favorite_count"] as? Int) ?? 0
        username = user["name"] as? String
        tweetID = dictionary["id_str"] as! String
       
        //if let hello = (dictionary["retweeted_status"]!["id_str"]){
          //  userID = hello as! String
        //}
        picUrl = user["profile_image_url_https"] as! String
        let timestampString = dictionary["created_at"]  as? String
        if let timestampString = timestampString {
            let formatter = NSDateFormatter()
            formatter.dateFormat = "EEE/MMM/d HH:mm:ss Z y"
            timestamp = formatter.dateFromString(timestampString)!
            
        
        }
    }

    class func tweetsWithArray(dictionaries: [NSDictionary]) -> [Tweet] {
        var tweets = [Tweet]()
        for dictionary in dictionaries {
            let tweet = Tweet(dictionary: dictionary)
            tweets.append(tweet)
            
        }
        return tweets
    
    }
    
    func timeAgoSince(date: NSDate) -> String {
        
        let calendar = NSCalendar.currentCalendar()
        let now = NSDate()
        let unitFlags: NSCalendarUnit = [.Second, .Minute, .Hour, .Day, .WeekOfYear, .Month, .Year]
        let components = calendar.components(unitFlags, fromDate: date, toDate: now, options: [])
        
        if components.day >= 1 {
            return "\(components.day)d"
        }
        
        if components.hour >= 1 {
            return "\(components.hour)h"
        }
        
        if components.minute >= 1 {
            return "\(components.minute)m"
        }
        
        if components.second >= 3 {
            return "\(components.second)s"
        }
        if components.second < 3 {
            return "Just now"
        }
        return "\(date)"
        
    }

}
