//
//  NewsTableViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 9/16/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import Foundation


class NewsTableViewController: UITableViewController
{
    var a = 1

    var selectedSources = [String]()
    var titleArray = [String]()
    var descriptionArray = [String]()
    var imageArray = [String]()
    var objects = [[String: String]]()
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        showArticle()
//    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("sources in newsTable: \(selectedSources)")
        navigationItem.hidesBackButton = true
       // navigationController?.navigationBarHidden = true
//        for i in selectedSources
//        {
//            for i in [articles].count {
//                
//            }
//        }
        
        
        // I will concatanate the source after source= in the urlStringInput to make it usable in a loop
        for i in selectedSources
        {
            let myUrlStringInput: String = "https://newsapi.org/v1/articles?source=" + i + "&sortBy=top&apiKey=ab8055c6a10b46e281e19b522c215120"
            print("myUrlStringInput #\(i): \(myUrlStringInput)")
            
//            let data = NSData(contentsOfURL: myUrlStringInput)
//            print("data is \(data)")
           
            if let nsurlStringInput = NSURL(string: myUrlStringInput)
            { // We have to convert to NSURL because contentsOfUrl takes NSURL as a paramater.
                //print("NSURL string input: \(nsurlStringInput)")
                
                if let websiteNSData = try? NSData(contentsOfURL: nsurlStringInput, options: [])
                { // We have to convert it to NSData because swiftyJSON's type JSON uses NSData as a paramter.
                    //print("Website's NSDATA: \(websiteNSData)")
                    
                    let websiteJSONData = JSON(data: websiteNSData)
                    // print("Website JSON Data: \(websiteJSONData)")
                    
                    parseJSON(websiteJSONData)
                }
            }
        }

        
//        let urlStringInput: String = "https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=ab8055c6a10b46e281e19b522c215120"

        
        // This url string will be typed into a text field to get info from a site.
        // print("URL string input: \(urlStringInput)")
        

                //TODO: FOR LOOP
               
//                if let myTitle = websiteJSONData["articles"][0]["title"].string
//                { // If I use newsapi.org I'll need to edit it for their formatting of their json
//                    //print("The 1st title is: \(myTitle)")
//                    titleArray.append(myTitle)
//                    print("number of articles: \(websiteJSONData["articles"].count)")
//                    
//                    print(myTitle)
//                    
//                    if let myDescription = websiteJSONData["articles"][0]["description"].string
//                    {
//                        //print("The 1st decsription is: \(myDescription)")
//                        descriptionArray.append(myDescription)
//                        
//                        print(myDescription)
//                        
//                        if let myImage = websiteJSONData["articles"][0]["urlToImage"].string
//                        {
//                            //print("myImage is: \(myImage)")
//                            imageArray.append(myImage)
//                        }
        
                            // get top rated articles for each subscribed source, append to array dictionary type data structure OR use https://newsapi.org/v1/articles
                           //  https://newsapi.org/v1/sources and sort out unsubscribed articles etc.
                            
                        
                     
                    
              
                //  if websiteJSONData["metadata"]["responseinfo"]["status"] == nil { // Check for a valid response code, could also check for "404" etc or if error != nil
                // TODO: Need to edit this cause only the whitehouse.gov site uses the metadata,responseinfo,status code, so on many sites this won't work.
                // We're ready to parse!
                // with newsapi I can check status == "ok"
                //print("Ready to parse!")
//            }
//            }
//        tableView.rowHeight = UITableViewAutomaticDimension
//        tableView.estimatedRowHeight = 250
}

     
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

    override func viewWillAppear(animated: Bool) {
        navigationController?.navigationBarHidden = true
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
        return objects.count
    }

   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //TODO: if there is no image received let cell = another cell class (as! otherCell) so that it loads a view without an image, with title and description scaled accordingly.
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! TableViewNewsCell

        let cellImg : UIImageView = UIImageView(frame: CGRectMake(5, 5, 90, 90))

//        cell.articleTitle.text = titleArray[0]
        let object = objects[indexPath.row]
       
        cell.articleTitle.text = object["title"]

        cell.articleDescription.text = object["description"]

       
        // why can't this be cell.articleImage.image = x ??
        
        // **** problem with http instead of https! Could do AllowsArbitraryLoads but bad for secuirty reasons, some sources like Hacker News don't have specified urls for image hosting, whereas Associated press does, so it can be excused in the info.plist. (binaryapi.ap.org)
        let imageString: String? = object["image"]
        print ("object[\"image\"] is: \(object["image"])")
//            if imageString == "" {
//              //  cellImg.image = UIImagenamed
//            }
//        print("Image STRING \(imageString)")

            if imageString != nil  {
                if let url: NSURL = NSURL(string: imageString!) {
                    if let data = NSData(contentsOfURL : url) {
                    let image = UIImage(data : data)
                    cellImg.image = image
                } else {
                    let image = UIImage(named: "imageNotFound")
                    cellImg.image = image
                }
                }
        // Need to center vertically
        
        //  let imageCenter = cell.frame.height / 2
        
               
     //   cellImg.image = image
        cellImg.layer.borderColor = UIColor.blackColor().CGColor
        cellImg.layer.borderWidth = 1
        cellImg.layer.cornerRadius = 10
        cellImg.clipsToBounds = true
        cell.addSubview(cellImg)
                }
        
    
        
      
        return cell
     
    }
    
 
    func parseJSON(json: JSON) {
        for article in json["articles"].arrayValue {
            let title = article["title"].stringValue
            let description = article["description"].stringValue
            let author = article["author"].stringValue
            let image = article["urlToImage"].stringValue
            let date = article["publishedAt"].stringValue
            let url = article["url"].stringValue
            let obj = ["title": title, "author": author, "image": image, "description": description, "date": date, "url": url]
            objects.append(obj)
        }
        
        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
            self.tableView.reloadData()
        }
    }
 






    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "toArticle"
        {
            print ("seg id is toArticle")
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
            let object = objects[indexPath.row]
            if let destination = segue.destinationViewController as? DetailViewController
            {
//                print("dest is \(destination)")
//                print(objects)
               // destination.objects = objects
                destination.object = object
            }
            
//            if let destination = segue.destinationViewController as? NewsTableViewController {
//                destination.selectedSources = selectedSources
//            }

                    // UINavigationController).topViewController as? DetailViewController
                // print((segue.destinationViewController as! UINavigationController).topViewController)
                //controller.detailItem = object
                //controller.navigationItem.hidesBackButton = false
            //}
        }
        
    }

//    func showArticle()
//    {
//        //performSegueWithIdentifier("toArticle", sender: nil)
//    }

}
}
