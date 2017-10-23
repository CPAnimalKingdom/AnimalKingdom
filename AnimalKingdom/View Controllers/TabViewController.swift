//
//  TabViewController.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/21/17.
//  Copyright © 2017 Dan. All rights reserved.
//

/* https://github.com/codepath/ios_guides/wiki/Creating-a-Custom-Tab-Bar */
import UIKit

class TabViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!

    var photosFeedViewController:  UIViewController!
    var profileViewController:  UIViewController!
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0
    var selectedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Creator", bundle: nil)
        photosFeedViewController = storyboard.instantiateViewController(withIdentifier: "PhotosFeedViewController")
        profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")

        viewControllers = [photosFeedViewController, profileViewController]

        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])

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

    @IBAction func didPressTab(_ sender: UIButton) {

        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()

        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)

        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)

    }
    
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            print("Camera is available 📸")
            vc.sourceType = .camera
        } else {
            print("Camera 🚫 available so we will use photo library instead")
            vc.sourceType = .photoLibrary
        }
        //vc.sourceType = UIImagePickerControllerSourceType.camera
        
        self.present(vc, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : Any]) {
        // Get the image captured by the UIImagePickerController
        let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        self.selectedImage = originalImage
        // Do something with the images (based on your use case)
        print("selected image is set")
        // Dismiss UIImagePickerController to go back to your original view controller
        dismiss(animated: true) {
            //segue to tagSegue
            self.performSegue(withIdentifier: "createPostSegue", sender: self)

        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if( segue.identifier == "createPostSegue" ){
            let vc = segue.destination as! UINavigationController
            let destinationViewController = vc.childViewControllers[0] as! CreatePostViewController
            destinationViewController.selectedAnimalImage = self.selectedImage
        }
    }
    
}
