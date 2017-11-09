//
//  BundleExplorerViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import Canvas
import AVFoundation


class BundleExplorerViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    var player = AVAudioPlayer()
    @IBOutlet var backgroundImageView: UIImageView!
    let bundles: [NSDictionary] = Datasource.data.bundleData
    var shownCellState = [Bool]()
    var dummyCounter: Int = 0
    @IBOutlet var bundleTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bundleTableView.delegate = self
        bundleTableView.dataSource = self
        bundleTableView.showsVerticalScrollIndicator = false
        shownCellState = [Bool](repeating: false, count: bundles.count)
        // Do any additional setup after loading the view.
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
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
//        let myHomeButton = UIImage(named: "home-icon")
//        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: myHomeButton, style: .plain, target: self, action: #selector(onHome))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bundles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bundleTableView.dequeueReusableCell(withIdentifier: "BundleTableViewCell", for: indexPath) as! BundleTableViewCell
        cell.bundleImageView.image = UIImage(named: bundles[indexPath.row]["image"] as! String)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
 func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        cell.alpha = 0
    
        UIView.animate(withDuration: 0.6, animations: {
            cell.alpha = 1
        })
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        playSound(named: "pop_drip")
    }
    
    @objc func onHome() {
        playSound(named: "digi_plink")
        self.navigationController?.popToRootViewController(animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let cell = sender as! UITableViewCell
        let indexPath = bundleTableView.indexPath(for: cell)
        let bundle: NSDictionary = bundles[indexPath!.row]
        
        // Pass the selected object to the new view controller.
        let animalExplorerViewController = segue.destination as! AnimalExplorerViewController
        animalExplorerViewController.bundle = bundle
    }
    
    @discardableResult func playSound(named soundName: String) -> AVAudioPlayer {
        let audioPath = Bundle.main.path(forResource: soundName, ofType: "wav")
        player = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        player.play()
        return player
    }
    
}
