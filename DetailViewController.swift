//
//  DetailViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 9/30/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailArticleImage: UIImageView!
    @IBOutlet weak var detailArticleTitle: UILabel!
    @IBOutlet weak var detailArticleSource: UILabel!
    @IBOutlet weak var detailArticleAuthor: UILabel!
    @IBOutlet weak var detailArticleDate: UILabel!
    @IBOutlet weak var detailArticleBody: UILabel!
    @IBOutlet weak var detailArticleURL: UILabel!

    
    let content = myJSON()
    var object = [String: String]()


    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Detail view did load")
        
        let detailURL =  "https://boilerpipe-web.appspot.com/extract?url=" + object["url"]! + "&output=json"
        
        content.objects = content.parseData(detailURL)
        let contentObject = content.objects[0]
        
        detailArticleBody.text = contentObject["content"]
        //print ("FLAG content \(contentObject["content"])")
        if contentObject["content"] != nil   {
            print("not nil")
        } else {
            print("nil")
        }
        //let test = contentObject["content"]
        // var firstChar = Array(test)[0]
        
        navigationController?.isNavigationBarHidden = false
        
        //Icon from icons8 - 32 png
        navigationItem.title = "test!"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Domain"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(switchToWeb))
        //navigationItem.backBarButtonItem!.image = #imageLiteral(resourceName: "Circled Left 2")
//        navigationItem.backBarButtonItem?.
//        print(object["image"])
        
        
        
        
        //&extractor=ArticleExtractor"
        /* "&extractor=" types from api:
         
         --ArticleExtractor	(default). A full-text extractor which is tuned towards news articles. In this scenario it achieves higher accuracy than DefaultExtractor.
         --DefaultExtractor	A quite generic full-text extractor, but usually not as good as ArticleExtractor.
         --LargestContentExtractor	Like DefaultExtractor, but only keeps the largest content block. Good for non-article style texts with only one main content block.
         --KeepEverythingExtractor	Treats everything as "content". Useful to track down SAX parsing errors.
 
         */
        
//        let myUrl = NSURL (string: object["url"]!)
//        let requestObj = URLRequest(url: myUrl as! URL)
//        detailArticleWebView.loadRequest(requestObj)
        //detailArticleSource.text = object["source"]
        let imageString = object["image"]
        
        if imageString != nil  {
            if let url: URL = URL(string: imageString!) {
                if let data = try? Data(contentsOf: url) {
                    let image = UIImage(data : data)
                    detailArticleImage.image = image
                } else {
                    let image = UIImage(named: "imageNotFound")
                    detailArticleImage.image = image
                }
            } 
            // Need to center vertically
            
//              let imageCenter = cell.frame.height / 2
//            
//            
//               cellImg.image = image
     
            
        

        }
        
        
      
        
        //print(content.objects)
        
        //print("objects in dvc: \(objects)")
        
        //let object = objects[indexPath.row]

        
        detailArticleTitle.text = object["title"]
       // detailArticleSource.text = object["source"]
        detailArticleAuthor.text = "By " + object["author"]!
        //detailArticleDescription.text = object["description"]
        detailArticleDate.text = object["date"]
        detailArticleURL.text = object["url"]
        
        //print("x: \(object["url"])")

        //detailArticleImage.image = object["image"]

        // Do any additional setup after loading the view.
    }

    func switchToWeb() {
        performSegue(withIdentifier: "toWeb", sender: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

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
        if segue.identifier == "toWeb"
        {
            print ("seg id is toWeb")
            let objectX = object["url"]
            print(object["url"])
                if let destination = segue.destination as? WebViewController
                {
                    destination.object = objectX!
                    print("jjj: \(objectX)")
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
  

}
