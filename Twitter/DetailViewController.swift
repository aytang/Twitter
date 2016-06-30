//
//  DetailViewController.swift
//  Twitter
//
//  Created by Allison Tang on 6/30/16.
//  Copyright © 2016 Allison Tang. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let message = tweet?.text {
            tweetLabel.text = "\(message)"
            let formatter = NSDateFormatter()
            formatter.dateFormat = "MMM/d/yy H:mm a"
            let timestamp = formatter.dateFromString(String(tweet.timestamp))
            //timestampLabel.text = "\(timestamp)"
            timestampLabel.text = "\(tweet.timestamp!)"
            usernameLabel.text = "\(tweet.username!)"
            retweetLabel.text = "\(tweet.retweetCount)"
            favoriteLabel.text = "\(tweet.favoritesCount)"
            handleLabel.text = "@\(tweet.handle)"
            ImageLoader.sharedLoader.imageForUrl(tweet.picUrl, completionHandler: { (image: UIImage?, url: String) in
                self.profileImageView.image = image!
                
            })
            profileImageView.layer.cornerRadius = 8.0
            profileImageView.clipsToBounds = true

        }
    }
        
        // Do any additional setup after loading the view.
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let profileViewController = segue.destinationViewController as! ProfileViewController
        profileViewController.tweet = tweet

        
    }


}
