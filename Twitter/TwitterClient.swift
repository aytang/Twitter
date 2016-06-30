//
//  TwitterClient.swift
//  Twitter
//
//  Created by Allison Tang on 6/27/16.
//  Copyright © 2016 Allison Tang. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

class TwitterClient: BDBOAuth1SessionManager {
    //static is like class, but lets to set a variable
    
    static let sharedInstance = TwitterClient(baseURL: NSURL(string: "https://api.twitter.com")!, consumerKey: "lklnXrTSM5bMV2r9TiXPiLkDK", consumerSecret: "K21xX2sGUtog5Ob1PI2WD69M0vPqlwdAALqvebz91lqq6nvjEM")
    
    var loginSuccess: (() -> ())?
    var loginFailure: ((NSError) -> ())?
    
    func handleOpenUrl(url: NSURL!){
        print (url.description)
        let requestToken = BDBOAuth1Credential(queryString: url.query)
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: requestToken, success: {(accessToken:BDBOAuth1Credential!) -> Void in
            //print ("I got the access token!")
            self.currentAccount({ (user: User) -> () in
                User.currentUser = user
                self.loginSuccess?()
                }, failure: { (error: NSError) in
                    self.loginFailure?(error)
            })
            //self.loginSuccess?()
          
        }) {(error: NSError!) -> Void in
            print ("error: \(error.description)")
            self.loginFailure?(error)
        }
    }
    
    func login(success: () -> (), failure: (NSError) -> ()) {
        loginSuccess = success
        loginFailure = failure
        deauthorize()
        fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "myTwitterapp://oauth"), scope: nil, success: {(requestToken: BDBOAuth1Credential!) -> Void in
            print ("I got the token!")
            let url = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")!
            UIApplication.sharedApplication().openURL(url)
            
            })
        {(error: NSError!) -> Void in
            print ("error: \(error.localizedDescription)")
            self.loginFailure?(error)
        }
    }
    
    func logout(){
        User.currentUser = nil
        deauthorize()
        NSNotificationCenter.defaultCenter().postNotificationName(User.userDidLogoutNotification, object: nil)
    }
    
    func favorite(tweetID: String) -> ()
    {
        let fullstr = "https://api.twitter.com/1.1/favorites/create.json?id=" + tweetID
        print (tweetID)
        POST(fullstr, parameters: nil, success: { ( task:NSURLSessionDataTask, response:AnyObject?) -> Void in
                print ("This has been favorited.")
                }, failure: { (task: NSURLSessionDataTask?, error: NSError?) -> Void in
            })
    }
 
    func retweet(userID: String) -> ()
    {
        let fullstr = "https://api.twitter.com/1.1/statuses/retweet/" + userID + ".json"
        POST(fullstr, parameters: nil, success: { ( task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            print ("This has been retweeted.")
            }, failure: { (task: NSURLSessionDataTask?, error: NSError?) -> Void in
        })

    }
    
    //how to declare a closure syntax
    func homeTimeline(success : ([Tweet])-> (), failure: (NSError) -> ()) {
        GET("1.1/statuses/home_timeline.json", parameters: nil, success: { ( task:NSURLSessionDataTask, response:AnyObject?) -> Void in
            let dictionaries = response as! [NSDictionary]
            let tweets = Tweet.tweetsWithArray(dictionaries)
            
            success(tweets)

            }, failure: { (task: NSURLSessionDataTask?, error: NSError?) -> Void in
                failure(error!)
        })
    } 

    func currentAccount(success: (User)-> (), failure: (NSError) -> ()) {
        GET("1.1/account/verify_credentials.json", parameters: nil, success: { (task: NSURLSessionDataTask, response: AnyObject?) ->  Void in
            //print ("account: \(response)")
            let userDictionary = response as! NSDictionary
            let user = User(dictionary: userDictionary)
            //print ("name: \(user.name)")
            success(user)
            
            }, failure:{ (task: NSURLSessionDataTask?, error: NSError?) -> Void in
                failure(error!)
        })

    }
}
