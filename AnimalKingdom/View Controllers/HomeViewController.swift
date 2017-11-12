//
//  HomeViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import AVFoundation

class HomeViewController: UIViewController {

    var audioPlayer = AVAudioPlayer()
    var player = AVAudioPlayer()
    
    @IBOutlet var backgroundImageView: UIImageView!
    override func viewDidLoad() {
    super.viewDidLoad()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "themeSong", ofType: "mp3")!))
            audioPlayer.prepareToPlay()
        } catch {
            print(error)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if UserDefaults.standard.bool(forKey: "kidsMode") == true {
            UserDefaults.standard.set(true, forKey: "kidsMode")
            backgroundImageView.image = UIImage(named: "background_k")
            if audioPlayer.isPlaying == true {
            } else {
                do {
                    audioPlayer = try AVAudioPlayer(contentsOf: URL.init(fileURLWithPath: Bundle.main.path(forResource: "themeSong", ofType: "mp3")!))
                    audioPlayer.prepareToPlay()
                    audioPlayer.play()
                } catch {
                    print(error)
                }
            }
            
        } else {
            UserDefaults.standard.set(false, forKey: "kidsMode")
            backgroundImageView.image = UIImage(named: "background")
            if audioPlayer.isPlaying == true {
                fadeVolumeAndStop(0.05)
            }
        }
        self.navigationController?.navigationBar.alpha = 0
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        let delay = DispatchTime.now() + 0.5
        DispatchQueue.main.asyncAfter(deadline: delay) {
            UIView.animate(withDuration: 0.5, animations: {
                self.navigationController?.navigationBar.alpha = 1
            }, completion: nil)
        }
        
//        let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow
//        UIView.animate(withDuration: 3) {
//            statusBarWindow?.alpha = 0
//        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @discardableResult func playSound(named soundName: String) -> AVAudioPlayer {
        let audioPath = Bundle.main.path(forResource: soundName, ofType: "wav")
        player = try! AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPath!) as URL)
        player.play()
        return player
    }
    
    func fadeVolumeAndStop(_ speed: Float){
        if self.audioPlayer.volume > 0.1 {
            self.audioPlayer.volume = self.audioPlayer.volume - speed
            let delay = DispatchTime.now() + 0.1
            DispatchQueue.main.asyncAfter(deadline: delay) {
                self.fadeVolumeAndStop(speed)
            }
            
        } else {
            self.audioPlayer.stop()
            self.audioPlayer.volume = 1.0
        }
    }
    
    @IBAction func onBigButton(_ sender: Any) {
        playSound(named: "pop_drip")
        if audioPlayer.isPlaying == true {
            fadeVolumeAndStop(0.02)
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

    @IBAction func unwindToHome(segue:UIStoryboardSegue) {
    }
}
