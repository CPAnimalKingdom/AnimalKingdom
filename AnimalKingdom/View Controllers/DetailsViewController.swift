//
//  DetailsViewController.swift
//  AnimalKingdom
//
//  Created by Dan on 10/16/17.
//  Copyright © 2017 Dan. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController{
    
    var animal: Animal!
    @IBOutlet var detailsTableView: UITableView!
    @IBOutlet var animalImageImageView: UIImageView!
    @IBOutlet var animalNameTextLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}

