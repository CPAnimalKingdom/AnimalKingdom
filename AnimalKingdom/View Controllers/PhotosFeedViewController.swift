//
//  PhotosFeedViewController.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/19/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import Firebase
import FirebaseFirestore
import UIKit

class PhotosFeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var localCollection: LocalCollection<Post>!

    @IBOutlet weak var feedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        feedTableView.dataSource = self
        feedTableView.delegate = self

        let collection = Firestore.firestore().collection("posts")
        localCollection = LocalCollection(query: collection) { [unowned self] (changes) in
            if self.localCollection.count == 0 {
                // self.feedTableView.backgroundView = self.backgroundView
                return
            } else {
                self.feedTableView.backgroundView = nil
            }
            var indexPaths: [IndexPath] = []

            // Only care about additions in this block, updating existing reviews probably not important
            // as there's no way to edit reviews.
            for addition in changes.filter({ $0.type == .added }) {
                let index = self.localCollection.index(of: addition.document)!
                let indexPath = IndexPath(row: index, section: 0)
                indexPaths.append(indexPath)
            }
            self.feedTableView.insertRows(at: indexPaths, with: .automatic)
        }
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell  = feedTableView.dequeueReusableCell(withIdentifier: "PhotoFeedCell", for: indexPath)
        let post = localCollection[indexPath.row]
        print(post)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localCollection.count
    }

}
