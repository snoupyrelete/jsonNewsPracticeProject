//
//  ViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 9/3/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import CoreGraphics



class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
   
    let listOfNewsSources = ["arsTechnica","associatedPress","bbcNews","bbcSports","bild","bloomberg","buzzFeed", "cnbc","cnn","dailyMail","engadget","entertainmentWeekly","espn","espnCricInfo", "financialTimes", "focus", "foxSports", "googleNews", "hackerNews", "ign", "independent", "mashable", "metro", "mirror", "nationalGeographic", "newScientist", "nflNews", "polygon", "recode", "redditRALL", "reuters", "skyNews", "skySportsNews", "spiegelOnline", "talksport", "techCrunch", "techradar", "theGuardianUK", "theHindu", "theHuffingtonPost", "theNewYorkTimes", "theNextWeb", "theTelegraph", "theTimesOfIndia", "theVerge", "theWallStreetJournal", "theWashingtonPost", "time", "usaToday", "wiredDe"]
    var selectedSources = [String]()
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfNewsSources.count
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
       
        let cell = collectionView.cellForItemAtIndexPath(indexPath)! as! NewsCell
        cell.newsLogo.layer.borderColor = UIColor.redColor().CGColor
    
        if collectionView.indexPathsForSelectedItems()?.count > 0 { // is this line necessary?
            // print("IP : \(indexPath)")
            let newSource = listOfNewsSources[indexPath.row]
          //  selectedSources.append("\(listOfNewsSources[indexPath])")
         //   print(String(listOfNewsSources[NSIndexPath]))
           // selectedSources.append(String(listOfNewsSources[NSIndexPath]))
            selectedSources.append(newSource)
            print("Selected sources: \(selectedSources)")
        }
     
    }
    
    // Resets borderColor to its default, unselected state.
    func collectionView(collectionView: UICollectionView, didDeselectItemAtIndexPath indexPath: NSIndexPath) {
        let cell = collectionView.cellForItemAtIndexPath(indexPath)! as! NewsCell
        cell.newsLogo.layer.borderColor = UIColor.yellowColor().CGColor
  
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("News Source", forIndexPath: indexPath) as! NewsCell
        
        let image = UIImage(named: listOfNewsSources[indexPath.row])
        cell.newsLogo.image = image
        
        let myLabel = listOfNewsSources[indexPath.row]
        cell.newsName.text = myLabel
        
        //for index in 0...listOfNewsSources.count {
        //let cell.UILabel.newsName = listOfNewsSources[indexPath]
        // {
        
        cell.layer.cornerRadius = 50
//        cell.clipsToBounds = true
//        cell.newsLogo.layer.masksToBounds = true
        
        
      //  cell.newsLogo.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        cell.newsLogo.layer.borderWidth = 5
        cell.newsLogo.layer.cornerRadius = cell.frame.size.width / 2

        
        return cell
        
    
        
      
        
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
  
        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
        button.backgroundColor = .greenColor()
        button.setTitle("Done", forState: .Normal)
        button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
        
        self.view.addSubview(button)
        
     
     

        // Detects first launch.
//        let launchedBefore = NSUserDefaults.standardUserDefaults().boolForKey("launchedBefore")
//        if launchedBefore  {
//            print("Not first launch.")
//           // presentViewController(tableViewController, sender: <#T##AnyObject?#>)
//            presentedViewController(tableViewController, animated: true, completion: nil)
//            performSegueWithIdentifier("toTable", sender: self)
           
            // grand central dispatch
//            dispatch_async(dispatch_get_main_queue()){
//                
//                self.performSegueWithIdentifier("toTable", sender: self)
//                
//            }
//        }
//        else {
//            print("First launch, setting NSUserDefault.")
//            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "launchedBefore")
//        }
   
        self.collectionView.allowsMultipleSelection = true
        
        
//        func indexPathsForSelectedItems() -> [NSIndexPath]? {
//            selectedSources.append(String(NSIndexPath))
//            
//            print("Selected sources: \(selectedSources)")
//            return [NSIndexPath]?
//        }
//    

        
        //TODO: ASYNC running with API calls.
        //TODO: CORE DATA NEWS SITES SUBSCRIPTIONS as collectionviews
        //TODO: HWS Names to Faces App for collection view help. (project 10)
        //TODO: ASSETS IMAGES SCALES AT DIFF SIZES 1x 2x 3x etc
        
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
                }
            
              //  if websiteJSONData["metadata"]["responseinfo"]["status"] == nil { // Check for a valid response code, could also check for "404" etc or if error != nil
                    // TODO: Need to edit this cause only the whitehouse.gov site uses the metadata,responseinfo,status code, so on many sites this won't work.
                    // We're ready to parse!
                // with newsapi I can check status == "ok"
 //print("Ready to parse!")
            }
        }
    }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buttonAction(sender: UIButton!) {
        print("Button tapped")
        performSegueWithIdentifier("toTable", sender: nil)
    }
    
    


}

