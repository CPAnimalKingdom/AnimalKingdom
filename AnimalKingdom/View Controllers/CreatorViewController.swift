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

class CreatorViewController: UIViewController, FBSDKLoginButtonDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var uploadButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    let imagePicker = UIImagePickerController()

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
