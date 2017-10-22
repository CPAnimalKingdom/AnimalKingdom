//
//  TabViewController.swift
//  AnimalKingdom
//
//  Created by Aabeeya on 10/21/17.
//  Copyright © 2017 Dan. All rights reserved.
//

/* https://github.com/codepath/ios_guides/wiki/Creating-a-Custom-Tab-Bar */
import UIKit

class TabViewController: UIViewController {

    @IBOutlet weak var contentView: UIView!
    @IBOutlet var buttons: [UIButton]!

    var photosFeedViewController:  UIViewController!
    var profileViewController:  UIViewController!
    var viewControllers: [UIViewController]!
    var selectedIndex: Int = 0


    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let storyboard = UIStoryboard(name: "Creator", bundle: nil)
        photosFeedViewController = storyboard.instantiateViewController(withIdentifier: "PhotosFeedViewController")
        profileViewController = storyboard.instantiateViewController(withIdentifier: "ProfileViewController")

        viewControllers = [photosFeedViewController, profileViewController]

        buttons[selectedIndex].isSelected = true
        didPressTab(buttons[selectedIndex])

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

    @IBAction func didPressTab(_ sender: UIButton) {

        let previousIndex = selectedIndex
        selectedIndex = sender.tag
        buttons[previousIndex].isSelected = false
        let previousVC = viewControllers[previousIndex]
        previousVC.willMove(toParentViewController: nil)
        previousVC.view.removeFromSuperview()
        previousVC.removeFromParentViewController()

        sender.isSelected = true
        let vc = viewControllers[selectedIndex]
        addChildViewController(vc)

        vc.view.frame = contentView.bounds
        contentView.addSubview(vc.view)
        vc.didMove(toParentViewController: self)







    }

}
