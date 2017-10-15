//
//  AnimalExplorerViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/9/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class AnimalExplorerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var bundle: NSDictionary!
    var animals: [Animal]!
    
    @IBOutlet var animalTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        animalTableView.delegate = self
        animalTableView.dataSource = self
        animals = Animal.animalArray(dictionaries: bundle["animals"]! as! [NSDictionary])
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = animalTableView.dequeueReusableCell(withIdentifier: "AnimalTableViewCell", for: indexPath) as! AnimalTableViewCell
        cell.animalNameTextLabel.text = "\(animals[indexPath.row].commonName)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = animalTableView.indexPath(for: cell)
        let animal: Animal = animals[indexPath!.row]
        
        // Pass the selected object to the new view controller.
        let detailsExplorerViewController = segue.destination as! DetailsViewController
        detailsExplorerViewController.animal = animal
    }

}
