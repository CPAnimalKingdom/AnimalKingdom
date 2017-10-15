//
//  CreatorViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

class CreatorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (FBSDKAccessToken.current() != nil) {
            // Do stuff post-login here
        } else {
            let loginButton = FBSDKLoginButton()
            loginButton.readPermissions = ["public_profile"]
            loginButton.center = self.view.center
            self.view.addSubview(loginButton)
        }
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

}
