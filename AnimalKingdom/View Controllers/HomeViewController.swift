//
//  HomeViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet var backgroundImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {

        if UserDefaults.standard.bool(forKey: "kidsMode") == true {
            UserDefaults.standard.set(true, forKey: "kidsMode")
            backgroundImageView.image = UIImage(named: "background_k")
        } else {
            UserDefaults.standard.set(false, forKey: "kidsMode")
            backgroundImageView.image = UIImage(named: "background")
        }
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
        let myBackButton = UIImage(named: "back-icon")

        self.navigationController?.navigationBar.backIndicatorImage = myBackButton
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = myBackButton
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        
        let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow
        UIView.animate(withDuration: 3) {
            statusBarWindow?.alpha = 0
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

    @IBAction func unwindToHome(segue:UIStoryboardSegue) {
    }
}
