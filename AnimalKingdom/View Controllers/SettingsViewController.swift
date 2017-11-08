//
//  SettingsViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import AVFoundation

class SettingsViewController: UITableViewController {

    @IBOutlet var kidsModeSwitch: UISwitch!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let myButton = UIImage(named: "camera")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: myButton, style: .plain, target: self, action: #selector(onHome))
        kidsModeSwitch.isOn = UserDefaults.standard.bool(forKey: "kidsMode")
    }

    @objc func onHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onDismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onKidsModeSwitch(_ sender: Any) {
        if kidsModeSwitch.isOn {
            UserDefaults.standard.set(true, forKey: "kidsMode")
        } else {
            UserDefaults.standard.set(false, forKey: "kidsMode")
        }
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
