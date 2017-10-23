//
//  CreatePostViewController.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/22/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class CreatePostViewController: UIViewController {
    
    
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var imageCaption: UITextView!
    
    var selectedAnimalImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalImage.image = selectedAnimalImage
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

    @IBAction func backButtonPressed(_ sender: Any) {
        // ideally go back to photo picker
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        print ("shareButtonPressed")
    }
    
    @IBAction func addLocationButtonPressed(_ sender: UIButton) {
        print ("addLocationPressed")

    }
    
}
