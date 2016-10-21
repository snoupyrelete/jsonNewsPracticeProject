//
//  NewsTableViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 9/16/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import Foundation
import ChameleonFramework

class NewsTableViewController: UITableViewController
{

//
//    var selectedSources = [String]()
    // set manually to debug for swrevealcontroller bc not passed in prepareforsegue
    //var selectedSources = [String]()
    
    
    var titleArray = [String]()
    var descriptionArray = [String]()
    var imageArray = [String]()
    var objects = [[String: String]]()
    
    let articles = myJSON()
    
    @IBOutlet weak var open: UIBarButtonItem!
    
    @IBAction func refreshControl(_ sender: AnyObject)
    {
        tableView.reloadData()
        refreshControl!.endRefreshing()
    }
    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        
        let testNavBarHeight = self.navigationController?.navigationBar.frame.height
        
        print("height::: \(testNavBarHeight)")
        let defaults = UserDefaults.standard
        let selectedSources = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()

        let image = UIImage(named: "smallNewsAppIcon")
        navigationItem.titleView = UIImageView(image: image)
        
        open.target = self.revealViewController()
        open.action = #selector(SWRevealViewController.revealToggle(_:))
        
        navigationController!.isToolbarHidden = true
        navigationController!.isNavigationBarHidden = false
    
        
        for i in selectedSources
        {
            
            let inputURL: String = "https://newsapi.org/v1/articles?source=" + i + "&sortBy=top&apiKey=ab8055c6a10b46e281e19b522c215120"
  
             articles.objects = articles.parseData(inputURL)
        }


                print("sources in newsTable: \(selectedSources)")
}

  
    override func viewWillAppear(_ animated: Bool) {
        //navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.objects.count
    }

   
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: if there is no image received let cell = another cell class (as! otherCell) so that it loads a view without an image, with title and description scaled accordingly. xib files?
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewNewsCell
        let object = articles.objects[(indexPath as NSIndexPath).row]
       // print("objecT: \(object)")
       
        cell.articleTitle.text = object["title"]
 
//        if let description = object["description"] {
//        let shortDesc = description.substring(to: description.index(description.startIndex, offsetBy: 101))
//        cell.articleDescription.text = shortDesc
//
//        }
        
        cell.articleDescription.text = object["description"]

        
        // **** problem with http instead of https! Could do AllowsArbitraryLoads but bad for secuirty reasons, some sources like Hacker News don't have specified urls for image hosting, whereas Associated press does, so it can be excused in the info.plist. (binaryapi.ap.org)
        let imageString: String? = object["image"]

        cell.articleImage.sd_setImage(with: URL(string: imageString!), placeholderImage: UIImage(named: "imageNotFound"))

        cell.backgroundColor = FlatWhite()
        cell.accessoryType = UITableViewCellAccessoryType.none
        
        return cell
    
    }
    
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
                    destination.object = object
                }
            }
        }
    }
}
