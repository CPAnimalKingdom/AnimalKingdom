//
//  DemoDetailsViewController_KM.swift
//  AnimalKingdom
//
//  Created by Dan on 11/8/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class DemoDetailsViewController_KM: UIViewController {
    
    @IBOutlet var viewContainer: UIView!
    @IBOutlet var videoView: UIWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoView.allowsInlineMediaPlayback = true
        videoView.loadHTMLString("<div align=\"center\"><iframe width=\"\(viewContainer.frame.width + 20)\" height=\"\(viewContainer.frame.height - 40)\" src=\"https://www.youtube.com/embed/qZrXDlmX0FY?rel=0&amp;showinfo=0&amp;start=11&amp;playsinline=1\" frameborder=\"0\" allowfullscreen></iframe></div>", baseURL: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        let myHomeButton = UIImage(named: "home-icon")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: myHomeButton, style: .plain, target: self, action: #selector(onHome))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onHome() {
        self.navigationController?.popToRootViewController(animated: true)
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

