//
//  BackgroundTableViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 10/11/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import ChameleonFramework

class BackgroundTableViewController: UITableViewController
{
    @IBOutlet weak var aboutLabel: UILabel!
    var tableArray = ["Manage subscriptions","About"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableView.backgroundColor = FlatWhite()
        aboutLabel.text = "Dylan Robson's Congressional App Challenge Submission \nCopyright 2016. \nAll rights reserved."
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        // #warning Incomplete implementation, return the number of rows
        return tableArray.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "backgroundCell", for: indexPath)
        
        cell.textLabel!.text = tableArray[indexPath.row]
       
        return cell
    }
}
