//
//  Tweet.swift
//  Twitter
//
//  Created by Allison Tang on 6/27/16.
//  Copyright © 2016 Allison Tang. All rights reserved.
//

import UIKit

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
            //print ("\(formatter.dateFromString(timestampString)!)")
           // var now = NSDate()
            //now = formatter.dateFromString(String(now))!
            //print (now)
            
           // if
           // else{
             timestamp = formatter.dateFromString(timestampString)!
           // }
            
        
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

}
