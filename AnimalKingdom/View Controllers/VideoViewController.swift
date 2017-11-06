//
//  VideoViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import WebKit
class VideoViewController: UIViewController {

    @IBOutlet var videoView_1: WKWebView!
    @IBOutlet var videoView_2: WKWebView!
    @IBOutlet var videoView_3: WKWebView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        videoView_1.loadHTMLString("<iframe width=\"100%\" height=\"100%\" src=\"https://www.youtube.com/embed/mlOiXMvMaZo\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        videoView_2.loadHTMLString("<iframe width=\"100%\" height=\"100%\" src=\"https://www.youtube.com/embed/2bpICIClAIg\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)
        videoView_3.loadHTMLString("<iframe width=\"100%\" height=\"100%\" src=\"https://www.youtube.com/embed/SNggmeilXDQ\" frameborder=\"0\" allowfullscreen></iframe>", baseURL: nil)

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
