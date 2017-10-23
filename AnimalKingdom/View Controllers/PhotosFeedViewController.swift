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
        self.feedTableView.rowHeight = 500;


        let collection = Firestore.firestore().collection("posts")
        localCollection = LocalCollection(query: collection) { [unowned self] (changes) in
            self.feedTableView.reloadData()
        }
        self.feedTableView.reloadData()
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
        let cell  = feedTableView.dequeueReusableCell(withIdentifier: "PhotoFeedCell", for: indexPath) as! PhotoFeedCell
        let post = localCollection[indexPath.row]
        cell.populate(post: post)
        print(post)
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return localCollection.count
    }

}
