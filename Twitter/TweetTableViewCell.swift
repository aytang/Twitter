//
//  TweetTableViewCell.swift
//  Twitter
//
//  Created by Allison Tang on 6/27/16.
//  Copyright © 2016 Allison Tang. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {
    
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    
    @IBOutlet weak var timestampLabel: UILabel!
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    
    
    var tweet: Tweet! {
        didSet {
            if let message = tweet?.text {
            tweetLabel.text = "\(message)"
            timestampLabel.text = "\(tweet.timestamp!)"
            usernameLabel.text = "\(tweet.username!)"
            retweetLabel.text = "\(tweet.retweetCount)"
            favoriteLabel.text = "\(tweet.favoritesCount)"
            ImageLoader.sharedLoader.imageForUrl(tweet.picUrl, completionHandler: { (image: UIImage?, url: String) in
                self.profileImageView.image = image!
            
            })
            profileImageView.layer.cornerRadius = 8.0
            profileImageView.clipsToBounds = true
            }
        }
    }
    @IBAction func toFavorite(sender: AnyObject) {
        print ("you hit the button")
        TwitterClient.sharedInstance.favorite(tweet.tweetID)
    }

    @IBAction func toRetweet(sender: AnyObject) {
        print ("you should be retweeting")
        //TwitterClient.sharedInstance.retweet(tweet.userID)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
