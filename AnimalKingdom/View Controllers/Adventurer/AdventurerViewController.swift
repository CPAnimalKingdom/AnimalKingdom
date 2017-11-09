//
//  AdventurerViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import Canvas
import AVFoundation

class AdventurerViewController: UIViewController {
    var player = AVAudioPlayer()
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var animalName: UILabel!
    @IBOutlet var animalImage: UIButton!
    @IBOutlet var animationView: CSAnimationView!
    @IBOutlet var buttonView: UIView!
    var dummyAdventurerCounter: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.dummyAdventurerCounter = 0

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

    @IBAction func onButton(_ sender: Any) {
        playSound(named: "digi_plink")
        let image = UIImage(named: "blur") as UIImage?
        animalImage.setImage(image, for: .normal)
        animationView.startCanvasAnimation()
        buttonView.startCanvasAnimation()
        setImage()
    }
    
    func setImage() {
        let delay = DispatchTime.now() + 0.4
        DispatchQueue.main.asyncAfter(deadline: delay) {
            if (self.dummyAdventurerCounter < 2)
            {
                self.playSound(named: "music_marimba")
                self.animalName.text = "THE BENGAL TIGER"
                let image = UIImage(named: "tiger-adventurer") as UIImage?
                self.animalImage.setImage(image, for: .normal)
                
                if UserDefaults.standard.bool(forKey: "kidsMode") == true {
                    let delay = DispatchTime.now() + 0.4
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        self.playSound(named: "tiger")
                    }
                }
                
            } else {
                self.playSound(named: "music_marimba")
                self.animalName.text = "THE AFRICAN ELEPHANT"
                let image = UIImage(named: "african-elephant-adventurer") as UIImage?
                self.animalImage.setImage(image, for: .normal)
                if UserDefaults.standard.bool(forKey: "kidsMode") == true {
                    let delay = DispatchTime.now() + 0.4
                    DispatchQueue.main.asyncAfter(deadline: delay) {
                        self.playSound(named: "elephant")
                    }
                }
            }
        }
        self.dummyAdventurerCounter = self.dummyAdventurerCounter + 1
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onHome() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    @IBAction func onBigButton(_ sender: Any) {
        self.playSound(named: "pop_drip")
        if UserDefaults.standard.bool(forKey: "kidsMode") == true {
            performSegue(withIdentifier: "ShowDemoDetails_KM", sender: nil)
        } else {
            performSegue(withIdentifier: "ShowDemoDetails", sender: nil)

        }

    }
    @discardableResult func playSound(named soundName: String) -> AVAudioPlayer {
        let audioPath = Bundle.main.path(forResource: soundName, ofType: "wav")
        player = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        player.play()
        return player
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
