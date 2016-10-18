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
        
        let defaults = UserDefaults.standard
        let selectedSources = defaults.stringArray(forKey: "SavedStringArray") ?? [String]()

        let image = UIImage(named: "Google News-2")
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


        let cellImg : UIImageView = UIImageView(frame: CGRect(x: 5, y: 5, width: 90, height: 90))

        cellImg.tag = 1
        let object = articles.objects[(indexPath as NSIndexPath).row]
       // print("objecT: \(object)")
       
        cell.articleTitle.text = object["title"]
        
       // print("object[\"title\"]: \(object["title"])")

        cell.articleDescription.text = object["description"]
    
        // why can't this be cell.articleImage.image = x ??
        
        // **** problem with http instead of https! Could do AllowsArbitraryLoads but bad for secuirty reasons, some sources like Hacker News don't have specified urls for image hosting, whereas Associated press does, so it can be excused in the info.plist. (binaryapi.ap.org)
        let imageString: String? = object["image"]

        //let imageView = cellImg.viewWithTag(2) as! UIImageView
        cellImg.contentMode = .scaleAspectFit
            //.UIViewContentMode = UIViewContentMode.scaleAspectFit

        
        
        //placeholder necessary to load correct images in cells.
        cellImg.sd_setImage(with: URL(string: imageString!), placeholderImage: UIImage(named: "imageNotFound"))

        cellImg.clipsToBounds = true
        cell.addSubview(cellImg)
        cell.backgroundColor = FlatWhite()
        
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
