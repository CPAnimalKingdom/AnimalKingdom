//
//  AdventurerViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import Canvas

class AdventurerViewController: UIViewController {

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

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        let myHomeButton = UIImage(named: "home-icon")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: myHomeButton, style: .plain, target: self, action: #selector(onHome))
    }

    @IBAction func onButton(_ sender: Any) {
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
                self.animalName.text = "THE BENGAL TIGER"
                let image = UIImage(named: "tiger-adventurer") as UIImage?
                self.animalImage.setImage(image, for: .normal)
            } else {
                self.animalName.text = "THE AFRICAN ELEPHANT"
                let image = UIImage(named: "african-elephant-adventurer") as UIImage?
                self.animalImage.setImage(image, for: .normal)
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
