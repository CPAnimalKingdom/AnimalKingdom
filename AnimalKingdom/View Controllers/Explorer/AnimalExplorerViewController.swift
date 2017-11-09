//
//  AnimalExplorerViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import AVFoundation

class AnimalExplorerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var player = AVAudioPlayer()
    @IBOutlet var backgroundImageView: UIImageView!
    var bundle: NSDictionary!
    var animals: [Animal]!
    
    @IBOutlet var animalTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        animalTableView.delegate = self
        animalTableView.dataSource = self
        animalTableView.showsVerticalScrollIndicator = false
        animals = Animal.animalArray(dictionaries: bundle["animals"]! as! [NSDictionary])
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
        let myHomeButton = UIImage(named: "home-icon")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: myHomeButton, style: .plain, target: self, action: #selector(onHome))
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = animalTableView.dequeueReusableCell(withIdentifier: "AnimalTableViewCell", for: indexPath) as! AnimalTableViewCell
        cell.animalImageView.image = UIImage(named: "\(animals[indexPath.row].details[0]["photo"] ?? "ERR")-explorer.jpg")
        
        

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
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
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = animalTableView.indexPath(for: cell)
        let animal: Animal = animals[indexPath!.row]
        
        // Pass the selected object to the new view controller.
        //let detailsViewController = segue.destination as! DetailsTableViewController
        //detailsViewController.animal = animal
    }
    
    @discardableResult func playSound(named soundName: String) -> AVAudioPlayer {
        let audioPath = Bundle.main.path(forResource: soundName, ofType: "wav")
        player = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        player.play()
        return player
    }
}

