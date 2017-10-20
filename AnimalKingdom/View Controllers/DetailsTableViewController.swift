//
//  DetailsTableViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/19/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class DetailsTableViewController: UITableViewController {

    var animal: Animal!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return animal.detailsArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let key = animal.detailsArray[indexPath.row].allKeys[0] as! NSString
        if key == "mainPhoto" {
            let cell = Bundle.main.loadNibNamed("DetailsHeaderImageTableViewCell", owner: self, options: nil)?.first as! DetailsHeaderImageTableViewCell
            cell.animalImageImageView.image = UIImage(named: "african-elephant-main.jpg")
            print("Key is \(key)")
            return cell
        } else if key == "name" {
            let cell = Bundle.main.loadNibNamed("DetailsTitleTableViewCell", owner: self, options: nil)?.first as! DetailsTitleTableViewCell
            cell.animalNameTextLabel.text = (animal.name["name"] as! String)
            return cell
        } else if key == "actions" {
            let cell = Bundle.main.loadNibNamed("DetailsActionsPanelTableViewCell", owner: self, options: nil)?.first as! DetailsActionsPanelTableViewCell
            return cell
        } else if key == "commonName" || key == "scientificName" ||  key == "type" || key == "diet" || key == "groupName" || key == "lifeSpan" || key == "size" || key == "weight"
        {
            let cell = Bundle.main.loadNibNamed("DetailsActionsPanelTableViewCell", owner: self, options: nil)?.first as! DetailsActionsPanelTableViewCell

            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("DetailsActionsPanelTableViewCell", owner: self, options: nil)?.first as! DetailsActionsPanelTableViewCell
            return cell
        }
        
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let key = animal.detailsArray[indexPath.row].allKeys[0] as! NSString
        if key == "mainPhoto" {
            return (tableView.frame.width/5) * 3
        } else if key == "name" {
            return (tableView.frame.width/6)
        } else if key == "actions" {
            return (tableView.frame.width/6)
        } else if key == "commonName" || key == "scientificName" ||  key == "type" || key == "diet" || key == "groupName" || key == "lifeSpan" || key == "size" || key == "weight" {
            return (tableView.frame.width/6)
        } else {
            return 0
        }
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
