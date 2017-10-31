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
        return animal.details.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let key = animal.details[indexPath.row].allKeys[0] as! NSString
        let value =  animal.details[indexPath.row]

        if key == "photo" {
            let cell = Bundle.main.loadNibNamed("DetailsHeaderImageTableViewCell", owner: self, options: nil)?.first as! DetailsHeaderImageTableViewCell
            cell.animalImageImageView.image = UIImage(named: "\(value[key] ?? "ERR")-main.jpg")
            return cell
        } else if key == "displayName" {
            let cell = Bundle.main.loadNibNamed("DetailsTitleTableViewCell", owner: self, options: nil)?.first as! DetailsTitleTableViewCell
            cell.animalNameTextLabel.text = value[key] as? String
            return cell
        } else if key == "actions" {
            let cell = Bundle.main.loadNibNamed("DetailsActionsPanelTableViewCell", owner: self, options: nil)?.first as! DetailsActionsPanelTableViewCell
            cell.ShowCreatorButton.addTarget(self, action: #selector(ShowCreator), for: UIControlEvents.touchUpInside)
            cell.ShowARButton.addTarget(self, action: #selector(ShowAR), for: UIControlEvents.touchUpInside)
            
            return cell
        } else if key == "COMMON NAME" || key == "SCIENTIFIC NAME" || key == "TYPE" || key == "DIET" || key == "GROUP NAME" || key == "AVERAGE LIFESPAN" || key == "SIZE" || key == "WEIGHT" {
            let cell = Bundle.main.loadNibNamed("DetailsCardTableViewCell", owner: self, options: nil)?.first as! DetailsCardTableViewCell
            cell.detailsCardItem.text = "\(key): \(value[key] ?? "ERR")"
            return cell
        } else {
            let cell = Bundle.main.loadNibNamed("DetailsAboutTableViewCell", owner: self, options: nil)?.first as! DetailsAboutTableViewCell
            cell.detailsAboutTitleTextLabel.text = "\(key)"
            cell.detailsAboutTextTextLabel.text = "\(value[key] ?? "ERR")"
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let key = animal.details[indexPath.row].allKeys[0] as! NSString
        if key == "photo" {
            return (tableView.frame.width / 5 ) * 3
        } else if key == "displayName" {
            return (tableView.frame.width / 6 )
        } else if key == "actions" {
            return (tableView.frame.width / 6 )
        } else if key == "COMMON NAME" || key == "SCIENTIFIC NAME" || key == "TYPE" || key == "DIET" || key == "GROUP NAME" || key == "AVERAGE LIFESPAN" || key == "SIZE" || key == "WEIGHT" {
            return (tableView.frame.width / 12 )
        } else if key == "Section 1" {
            return 100
        } else {
            return 20
        }
    }
    
    @objc func ShowAR() {
        performSegue(withIdentifier: "ShowAR", sender: nil)
    }

    @objc func ShowCreator() {
        performSegue(withIdentifier: "ShowCreator", sender: nil)
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
