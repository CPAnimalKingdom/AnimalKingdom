//
//  CreatePostViewController.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/22/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import Photos
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseStorage
import MBProgressHUD

class CreatePostViewController: UIViewController {
    
    
    @IBOutlet weak var animalImage: UIImageView!
    
    @IBOutlet weak var imageCaption: UITextView!
    
    var selectedAnimalImage: UIImage!
    var imageLocation: CLLocation!
    var user: User!

    let storageRef = Storage.storage().reference()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        animalImage.image = selectedAnimalImage
        imageCaption.becomeFirstResponder()

        let uid = Auth.auth().currentUser!.uid
        let docRef = db.collection("users").document(uid)
        docRef.getDocument { (document, error) in
            if let user = document.flatMap({ User(id: uid, dictionary: $0.data()) }) {
                self.user = user
            } else {
                print("Document does not exist")
            }
        }
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
        MBProgressHUD.showAdded(to: self.view, animated: true)

        let captionText = imageCaption.text!

        let data = UIImageJPEGRepresentation(animalImage.image!, 0.8)!
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        let uuid = UUID().uuidString
        let imageRef = storageRef.child("images/\(uuid).jpg")
        imageRef.putData(data, metadata: metadata) { (metadata, error) in
            guard let metadata = metadata else {
                // Uh-oh, an error occurred!
                return
            }
            // Metadata contains file metadata such as size, content-type, and download URL.
            let downloadURL = metadata.downloadURL()

            let post = Post.init(userId: self.user.id, userName: self.user.name, photoUrl: downloadURL!.absoluteString, imageCaption: captionText, animalTag: "", dateImageTaken: "", locationTag: "")
            post.save()

            MBProgressHUD.hide(for: self.view, animated: true)

            self.dismiss(animated: true, completion: nil)
        }
        
    }
    
    @IBAction func addLocationButtonPressed(_ sender: UIButton) {
        print ("addLocationPressed")

    }
    
}
