//
//  ProfileViewController.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/22/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit
import Firebase
import FirebaseFirestore

class ProfileViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var colllectionView: UICollectionView!
    var localCollection: LocalCollection<Post>!
    var myImage: UIImage? = nil


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        colllectionView.delegate = self
        colllectionView.dataSource = self

        let currentUser = Auth.auth().currentUser
        let userId = currentUser!.uid;

        let collection = Firestore.firestore().collection("posts").whereField("userId", isEqualTo:userId)
        localCollection = LocalCollection(query: collection) { [unowned self] (changes) in
            self.colllectionView.reloadData()
        }
        self.colllectionView.reloadData()
    }

    deinit {
        if (localCollection != nil) {
            localCollection.stopListening()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localCollection.listen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if (segue.identifier == "postDetailsSegue") {
            let vc = segue.destination as! UINavigationController
            let postDetailsVC = vc.childViewControllers[0] as! PostDetailsViewController
            let postIndex = colllectionView.indexPathsForSelectedItems![0].row
            postDetailsVC.post = localCollection[postIndex]
        }
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localCollection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell =  colllectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        let post = localCollection[indexPath.row]

        cell.animalImage.image = UIImage(named: "defaultPictureIcon")
        DispatchQueue.global().async {
            do {
                if let imageURL = NSURL(string: post.photoUrl) {
                    if let data = NSData(contentsOf: imageURL as URL) {
                        self.myImage = UIImage(data: data as Data)
                    }
                }
            }
            DispatchQueue.main.async {
                if self.myImage != nil {
                    UIView.transition(with: cell.animalImage,
                                      duration: 0.5,
                                      options: .transitionCrossDissolve,
                                      animations: { cell.animalImage.image = self.myImage },
                                      completion: nil)
                }
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
}
