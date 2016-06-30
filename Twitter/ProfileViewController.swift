//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Allison Tang on 6/30/16.
//  Copyright © 2016 Allison Tang. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    var tweet: Tweet!
    
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var handleLabel: UILabel!
    
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let message = tweet?.text {
        followingCount.text = "\(tweet.followingCount!)"
        followersCount.text = "\(tweet.followersCount!)"
        tweetsCount.text = "\(tweet.tweetsCount!)"
        taglineLabel.text = "\(tweet.tagline!)"
            usernameLabel.text = "\(tweet.username!)"

            handleLabel.text = "@\(tweet.handle)"
            ImageLoader.sharedLoader.imageForUrl(tweet.picUrl, completionHandler: { (image: UIImage?, url: String) in
                self.profileImageView.image = image!
                
            })
            profileImageView.layer.cornerRadius = 8.0
            profileImageView.clipsToBounds = true
        }
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
