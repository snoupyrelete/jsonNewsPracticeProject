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


    var selectedSources = [String]()
    var titleArray = [String]()
    var descriptionArray = [String]()
    var imageArray = [String]()
    var objects = [[String: String]]()
    
    let articles = myJSON()
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        showArticle()
//    }
    

   
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
   
        
        for i in selectedSources
        {
            
            let inputURL: String = "https://newsapi.org/v1/articles?source=" + i + "&sortBy=top&apiKey=ab8055c6a10b46e281e19b522c215120"
            print(inputURL)
            
             articles.objects = articles.parseData(inputURL)
        }
        
        
        DispatchQueue.main.async { [unowned self] in
            self.tableView.reloadData()
        }

        
        // test for article url
        //let ABC = xSources.parseData("https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=ab8055c6a10b46e281e19b522c215120")
        // test for source url
        //let ABC = xSources.parseData("https://newsapi.org/v1/sources?language=en")
        //test for boilerpipe url
                print("sources in newsTable: \(selectedSources)")
        navigationItem.hidesBackButton = true

        
        // I will concatanate the source after source= in the urlStringInput to make it usable in a loop
 
        
//        let urlStringInput: String = "https://newsapi.org/v1/articles?source=associated-press&sortBy=top&apiKey=ab8055c6a10b46e281e19b522c215120"


        
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

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("objects count \(articles.objects.count)")
        return articles.objects.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: if there is no image received let cell = another cell class (as! otherCell) so that it loads a view without an image, with title and description scaled accordingly. xib files?
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewNewsCell
        print("objects from myJSON to tableview in cellforrow \(articles.objects)")
//        
//        var objects = articles.objects
        
//        print("objects 1 in cellforrow\(objects)")
        let cellImg : UIImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 90, height: 90))

        let object = articles.objects[(indexPath as NSIndexPath).row]
       // print("objecT: \(object)")
       
        cell.articleTitle.text = object["title"]
        
       // print("object[\"title\"]: \(object["title"])")

        cell.articleDescription.text = object["description"]

       
        // why can't this be cell.articleImage.image = x ??
        
        // **** problem with http instead of https! Could do AllowsArbitraryLoads but bad for secuirty reasons, some sources like Hacker News don't have specified urls for image hosting, whereas Associated press does, so it can be excused in the info.plist. (binaryapi.ap.org)
        let imageString: String? = object["image"]
        //print ("object[\"image\"] is: \(object["image"])")
//            if imageString == "" {
//              //  cellImg.image = UIImagenamed
//            }
//        print("Image STRING \(imageString)")

            if imageString != nil  {
                if let url: URL = URL(string: imageString!) {
                    if let data = try? Data(contentsOf: url) {
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
        cellImg.layer.borderColor = UIColor.black.cgColor
        cellImg.layer.borderWidth = 1
        cellImg.layer.cornerRadius = 10
        cellImg.clipsToBounds = true
        cell.addSubview(cellImg)
                }

        return cell
    
    }
    
 
//    func parseJSON(json: JSON) {
//        for article in json["articles"].arrayValue {
//            let title = article["title"].stringValue
//            let description = article["description"].stringValue
//            let author = article["author"].stringValue
//            let image = article["urlToImage"].stringValue
//            let date = article["publishedAt"].stringValue
//            let url = article["url"].stringValue
//            let obj = ["title": title, "author": author, "image": image, "description": description, "date": date, "url": url]
//            objects.append(obj)
//        }
//        
//        dispatch_async(dispatch_get_main_queue()) { [unowned self] in
//            self.tableView.reloadData()
//        }
//    }
 






    /*
    // MARK: - Navigation
     
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toArticle"
        {
            print ("seg id is toArticle")
            if let indexPath = self.tableView.indexPathForSelectedRow
            {
            let object = articles.objects[(indexPath as NSIndexPath).row]
            if let destination = segue.destination as? DetailViewController
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
