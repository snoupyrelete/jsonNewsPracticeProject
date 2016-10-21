//
//  BackgroundTableViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 10/11/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import ChameleonFramework
import NYAlertViewController

class BackgroundTableViewController: UITableViewController
{
    @IBOutlet weak var aboutLabel: UILabel!
    var tableArray = ["Manage subscriptions","About"]
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
       
        
        
        tableView.backgroundColor = FlatWhite()
        aboutLabel.text = "Dylan Robson's Congressional App Challenge Submission \nCopyright 2016. \nAll rights reserved."
        tableView.tableFooterView = UIView()
        //tableView.tableFooterView!.backgroundColor = FlatRed()
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            performSegue(withIdentifier: "toSubs", sender: nil)
        } else if indexPath.row == 1 {
            
            let avc = NYAlertViewController.alert(withTitle: "Dylan's News App", message: "V1.0\n Created on September 10, 2016,\n Submitted from Draper Utah,\n under congressman Jason Chaffetz of district 3.\n \nI am a senior at Corner Canyon High School. This was my first \"real\" app and it's been a tremendous learning experience\n \nWritten is Xcode 8, Swift 3\n Credit to: BEMCheckBox, ChameleonFrameWork, NYAlertViewController, SDWebImage, Newsapi.org, Boilerpipe API, Icons 8, SwiftyJSON")
            avc!.swipeDismissalGestureEnabled = true
            avc!.backgroundTapDismissalGestureEnabled = true
            self.present(avc!, animated: true, completion: nil)
            //performSegue(withIdentifier: "toAbout", sender: nil)
        }
    }
}
