//
//  SWViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 10/11/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit

class SWViewController: SWRevealViewController {

//    let navVC = segue.destination as! SWRevealViewController
//    
//    let tableVC = navVC.viewControllers.first as NewsTableViewController

    var selectedSources = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        if segue.identifier == "sw_front" {
            let navVC = segue.destination as! UINavigationController
            
            let tableVC = navVC.viewControllers.first as! NewsTableViewController
            
            tableVC.selectedSources = selectedSources
        }


    }
 

}
