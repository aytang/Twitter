//
//  UserViewController.swift
//  Twitter
//
//  Created by Allison Tang on 6/30/16.
//  Copyright © 2016 Allison Tang. All rights reserved.
//

import UIKit

class UserViewController: UIViewController {

    var user: User!
    
    @IBOutlet weak var profImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var handleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var tweetsCount: UILabel!
    @IBOutlet weak var followersCount: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        usernameLabel.text = "\(user.name!)"
        taglineLabel.text = "\(user.tagline!)"
        handleLabel.text = "\(user.screenname!)"
        tweetsCount.text = "\(user.tweetsCount!)"
        followingCount.text = "\(user.followingCount!)"
        followersCount.text = "\(user.followersCount!)"
        
        // Do any additional setup after loading the view.
        if let pic = user.profileUrl {
        ImageLoader.sharedLoader.imageForUrl(pic, completionHandler: { (image: UIImage?, url: String) in
            self.profImageView.image = image!
            
        })
        }
        profImageView.layer.cornerRadius = 8.0
        profImageView.clipsToBounds = true
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
