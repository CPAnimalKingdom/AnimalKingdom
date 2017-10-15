//
//  BundleExplorerViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class BundleExplorerViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {

    let bundles: [NSDictionary] = Datasource.data.bundleData
    @IBOutlet var bundleTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        bundleTableView.delegate = self
        bundleTableView.dataSource = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bundles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = bundleTableView.dequeueReusableCell(withIdentifier: "BundleTableViewCell", for: indexPath) as! BundleTableViewCell
        cell.bundleNameTextLabel.text = "\(bundles[indexPath.row]["name"] ?? "Error: Bundle name not available")"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        let cell = sender as! UITableViewCell
        let indexPath = bundleTableView.indexPath(for: cell)
        let bundle: NSDictionary = bundles[indexPath!.row]
        
        // Pass the selected object to the new view controller.
        let animalExplorerViewController = segue.destination as! AnimalExplorerViewController
        animalExplorerViewController.bundle = bundle
    }
}
