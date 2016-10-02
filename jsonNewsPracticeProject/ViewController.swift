//
//  ViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 9/3/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import CoreGraphics
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func > <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l > r
  default:
    return rhs < lhs
  }
}




class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    
    let sources = myJSON()
   // TODO: get nessources and associated info and logo programatically.
//    let listOfNewsSources = ["ars-technica","associated-press","bbcNews","bbcSports","bild","bloomberg","buzzFeed", "cnbc","cnn","dailyMail","engadget","entertainmentWeekly","espn","espnCricInfo", "financialTimes", "focus", "foxSports", "googleNews", "hacker-news", "ign", "independent", "mashable", "metro", "mirror", "nationalGeographic", "newScientist", "nflNews", "polygon", "recode", "redditRALL", "reuters", "skyNews", "skySportsNews", "spiegelOnline", "talksport", "techCrunch", "techradar", "theGuardianUK", "theHindu", "theHuffingtonPost", "theNewYorkTimes", "theNextWeb", "theTelegraph", "theTimesOfIndia", "theVerge", "theWallStreetJournal", "theWashingtonPost", "time", "usaToday", "wiredDe"]
    var selectedSources = [String]()
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sources.objects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        let cell = collectionView.cellForItem(at: indexPath)! as! NewsCell
        cell.newsLogo.layer.borderColor = UIColor.red.cgColor
    
        if collectionView.indexPathsForSelectedItems?.count > 0 { // is this line necessary?
            // print("IP : \(indexPath)")
            let object = sources.objects[(indexPath as NSIndexPath).row]
            
            let newSource = object["id"]
          //  selectedSources.append("\(listOfNewsSources[indexPath])")
         //   print(String(listOfNewsSources[NSIndexPath]))
           // selectedSources.append(String(listOfNewsSources[NSIndexPath]))
            selectedSources.append(newSource!)
            print("Selected sources: \(selectedSources)")
        }
     
    }
    
    // Resets borderColor to its default, unselected state.
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)! as! NewsCell
        cell.newsLogo.layer.borderColor = UIColor.yellow.cgColor
  
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "News Source", for: indexPath) as! NewsCell
        
        let object = sources.objects[(indexPath as NSIndexPath).row]
        
        let imageString: String? = object["image"]
        
        print(imageString)
        if imageString != nil  {
            if let url: URL = URL(string: imageString!) {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data : data)
                    cell.newsLogo.image = image
                } else {
                    let image = UIImage(named: "imageNotFound")
                    cell.newsLogo.image = image
                }
            }
 
        }
        
        //let image = UIImage(named: listOfNewsSources[indexPath.row])
        
        //cell.newsLogo.image = image
        
        cell.newsName.text = object["name"]
        
//        let myLabel = listOfNewsSources[indexPath.row]
//        cell.newsName.text = myLabel
        
        //for index in 0...listOfNewsSources.count {
        //let cell.UILabel.newsName = listOfNewsSources[indexPath]
        // {
        
        cell.layer.cornerRadius = 50
//        cell.clipsToBounds = true
//        cell.newsLogo.layer.masksToBounds = true
        
        
      //  cell.newsLogo.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).CGColor
        cell.newsLogo.layer.borderWidth = 5
        cell.newsLogo.layer.cornerRadius = cell.frame.size.width / 2
        cell.newsLogo.clipsToBounds = false

        
        return cell
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Subscriptions"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(buttonAction))
        navigationItem.hidesBackButton = true
        
        sources.objects = sources.parseData("https://newsapi.org/v1/sources?language=en")
        print("sources.objects are \(sources.objects)")
     
        
//        let navBar: UINavigationBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: 320, height: 44))
//        self.view.addSubview(navBar);
//        let navItem = UINavigationItem(title: "Select Your Sources");
//        let doneItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: nil, action: #selector(buttonAction));
//        navItem.rightBarButtonItem = doneItem;
//        navBar.setItems([navItem], animated: true);
        
        
  
//        let button = UIButton(frame: CGRect(x: 100, y: 100, width: 100, height: 50))
//        button.backgroundColor = .greenColor()
//        button.setTitle("Done", forState: .Normal)
//        button.addTarget(self, action: #selector(buttonAction), forControlEvents: .TouchUpInside)
//        
//        self.view.addSubview(button)
//        
     
     

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
        
           }

     override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toTable" {
            print ("seg id is toTable")
            if let destination = segue.destination as? NewsTableViewController {
                destination.selectedSources = selectedSources
            }
        }
    }
    
    func buttonAction(_ sender: UIButton!) {
        print("Button tapped")
        performSegue(withIdentifier: "toTable", sender: nil)
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let vc = storyboard.instantiateViewControllerWithIdentifier("NewsTableViewController") as! UITableViewController
//        self.navigationController!.pushViewController(vc, animated: true)
//        print(vc)
    }
}

