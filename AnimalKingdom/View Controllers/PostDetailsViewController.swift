//
//  PostDetailsViewController.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/22/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class PostDetailsViewController: UIViewController {
    
    @IBOutlet weak var facebookProfileImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var locationTag: UILabel!
    @IBOutlet weak var animalImage: UIImageView!
    @IBOutlet weak var caption: UILabel!
    @IBOutlet weak var timestamp: UILabel!

    var post: Post!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.username.text = post.userName
        self.caption.text = post.imageCaption
        self.timestamp.text = post.dateImageTaken
        
        // Load image
        let url = URL(string: post.photoUrl)
        let data = try? Data(contentsOf: url!) //make sure your image in this url does exist, otherwise unwrap in a if let check / try-catch
        self.animalImage.image = UIImage(data: data!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true
            , completion: nil)
    }
}
