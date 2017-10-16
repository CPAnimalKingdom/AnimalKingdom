//
//  CreatorViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseStorage
import MBProgressHUD

class CreatorViewController: UIViewController, FBSDKLoginButtonDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    let imagePicker = UIImagePickerController()
    let storageRef = Storage.storage().reference()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let loginButton = FBSDKLoginButton()
        loginButton.delegate = self
        loginButton.readPermissions = ["public_profile"]
        loginButton.center = self.view.center
        self.view.addSubview(loginButton)

        imagePicker.delegate = self

        if (Auth.auth().currentUser != nil) {
            // If there is a logged in Firebase user
            // TODO: What if Firebase user and FB user go out of sync e.g. password reset on FB
            self.addUploadButton()

            // Attempt to get user name and profile picture URL
            let request = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "name, picture.type(large)"])
            let _ = request?.start(completionHandler: { (connection, result, error) in
                guard let userInfo = result as? [String: Any] else { return } //handle the error

                let userName = userInfo["name"] as! String;

                //The url is nested 3 layers deep into the result so it's pretty messy
                let pictureUrlString = ((userInfo["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as! String
                let uid = Auth.auth().currentUser!.uid

                let user = User(id: uid, name: userName, profileImageUrl: pictureUrlString)
                user.save()
            })
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addUploadButton() {
        self.uploadButton!.isHidden = false
        self.imageView!.isHidden = false
    }

    func removeUploadButton () {
        self.uploadButton!.isHidden = true
        self.imageView!.isHidden = true
    }

    @IBAction func uploadButtonTapped(_ sender: Any) {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary

        present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.contentMode = .scaleAspectFit
            imageView.image = pickedImage
            imageView.isHidden = false

            let uuid = UUID().uuidString
            let imageRef = storageRef.child("images/\(uuid).jpg")

            // Display HUD right before the request is made
            MBProgressHUD.showAdded(to: self.view, animated: true)

            // Upload the file to the path "images/{UUID}.jpg"
            let data = UIImageJPEGRepresentation(pickedImage, 0.8)!
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            let _uploadTask = imageRef.putData(data, metadata: metadata) { (metadata, error) in
                guard let metadata = metadata else {
                    // Uh-oh, an error occurred!
                    return
                }
                // Metadata contains file metadata such as size, content-type, and download URL.
                let downloadURL = metadata.downloadURL
                print(downloadURL)
                MBProgressHUD.hide(for: self.view, animated: true)
            }
        }

        dismiss(animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential) { (user, error) in
            if let error = error {
                // Firebase Authentication error
                print(error.localizedDescription)
                return
            }
            // User is signed in
            // Do stuff
            self.addUploadButton()
        }
    }

    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
            self.removeUploadButton()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
