//
//  DemoKidsTextViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 11/11/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class DemoKidsTextViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "bar-backgound-64"), for: .default)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        let myHomeButton = UIImage(named: "home-icon-1")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: myHomeButton, style: .plain, target: self, action: #selector(onHome))
        self.navigationController?.navigationBar.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.navigationController?.navigationBar.alpha = 1
        }, completion: nil)

    }
    
    @objc func onHome() {
        self.navigationController?.popToRootViewController(animated: true)
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
