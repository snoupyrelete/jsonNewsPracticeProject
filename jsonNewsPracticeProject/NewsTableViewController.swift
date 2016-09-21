//
//  NewsTableViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 9/16/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {

    var titleArray = [String]()
    var descriptionArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let urlStringInput: String = "https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=ab8055c6a10b46e281e19b522c215120"
        
        // This url string will be typed into a text field to get info from a site.
        // print("URL string input: \(urlStringInput)")
        
        if let nsurlStringInput = NSURL(string: urlStringInput) { // We have to convert to NSURL because contentsOfUrl takes NSURL as a paramater.
            //print("NSURL string input: \(nsurlStringInput)")
            
            if let websiteNSData = try? NSData(contentsOfURL: nsurlStringInput, options: []) { // We have to convert it to NSData because swiftyJSON's type JSON uses NSData as a paramter.
                //print("Website's NSDATA: \(websiteNSData)")
                
                let websiteJSONData = JSON(data: websiteNSData)
                //print("Website JSON Data: \(websiteJSONData)")
                
                if let myTitle = websiteJSONData["articles"][0]["title"].string { // If I use newsapi.org I'll need to edit it for their formatting of their json
                    //print("The 1st title is: \(myTitle)")
                    titleArray.append(myTitle)
                    
                    if let myDescription = websiteJSONData["articles"][0]["description"].string {
                        //print("The 1st decsription is: \(myDescription)")
                        descriptionArray.append(myDescription)

                    
                    }
                }
                
                //  if websiteJSONData["metadata"]["responseinfo"]["status"] == nil { // Check for a valid response code, could also check for "404" etc or if error != nil
                // TODO: Need to edit this cause only the whitehouse.gov site uses the metadata,responseinfo,status code, so on many sites this won't work.
                // We're ready to parse!
                // with newsapi I can check status == "ok"
                //print("Ready to parse!")
            }
        }

     
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 20
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewNewsCell

        cell.textLabel!.text = titleArray[0]
        cell.detailTextLabel!.text = descriptionArray[0]
        cell.imageView!.image = UIImage(named: "bbcNews")
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
