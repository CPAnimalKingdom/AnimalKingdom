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

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        colllectionView.delegate = self
        colllectionView.dataSource = self

        let currentUser = Auth.auth().currentUser
        let userId = currentUser!.uid;

        let collection = Firestore.firestore().collection("posts").whereField("userId", isEqualTo:userId)
        localCollection = LocalCollection(query: collection) { [unowned self] (changes) in
            var indexPaths: [IndexPath] = []

            // Only care about additions in this block, updating existing reviews probably not important
            // as there's no way to edit reviews.
            for addition in changes.filter({ $0.type == .added }) {
                let index = self.localCollection.index(of: addition.document)!
                let indexPath = IndexPath(row: index, section: 0)
                indexPaths.append(indexPath)
            }
            //self.colllectionView.insertRows(at: indexPaths, with: .automatic)
            self.colllectionView.insertItems(at: indexPaths)
        }
        self.colllectionView.reloadData()
    }

    deinit {
        localCollection.stopListening()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        localCollection.listen()
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
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return localCollection.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell =  colllectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCollectionViewCell", for: indexPath) as! ProfileCollectionViewCell
        let post = localCollection[indexPath.row]
        if let imageURL = NSURL(string: post.photoUrl) {
            if let data = NSData(contentsOf: imageURL as URL) {
                cell.animalImage.image = UIImage(data: data as Data)
            }
        }
        return cell
    }

}
