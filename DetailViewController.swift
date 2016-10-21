//
//  DetailViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 9/30/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import SwiftDate
import ChameleonFramework

class DetailViewController: UIViewController {

    @IBOutlet weak var detailArticleImage: UIImageView!
    @IBOutlet weak var detailArticleTitle: UILabel!
    @IBOutlet weak var detailArticleSource: UILabel!
    @IBOutlet weak var detailArticleAuthor: UILabel!
    @IBOutlet weak var detailArticleDate: UILabel!
    @IBOutlet weak var detailArticleBody: UILabel!
    @IBOutlet weak var detailArticleURL: UILabel!
    @IBOutlet weak var webButton: UIButton!

    @IBAction func webViewButtonTouched(_ sender: AnyObject)
    {
        switchToWeb()
    }

    let content = myJSON()
    var object = [String: String]()


    override func viewWillAppear(_ animated: Bool) {
        navigationController!.isToolbarHidden = true
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
    }

    
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
     
       
        #imageLiteral(resourceName: "webButton").draw(in: webButton.bounds)

        print("ob author: \(object["author"])")
        webButton.layer.cornerRadius = 6
        print("Detail view did load")
        
        let detailURL =  "https://boilerpipe-web.appspot.com/extract?url=" + object["url"]! + "&output=json"
        
        content.objects = content.parseData(detailURL)
        let contentObject = content.objects[0]
        
        detailArticleBody.text = contentObject["content"]
        print("content")
        print (contentObject["content"])
        if contentObject["content"] != nil   {
            print("not nil")
        } else {
            print("nil")
        }

        //Icon from icons8 - 32 png
        //navigationItem.title = nil
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Domain"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(switchToWeb))

        
        
        //&extractor=ArticleExtractor"
        /* "&extractor=" types from api:
         
         --ArticleExtractor	(default). A full-text extractor which is tuned towards news articles. In this scenario it achieves higher accuracy than DefaultExtractor.
         --DefaultExtractor	A quite generic full-text extractor, but usually not as good as ArticleExtractor.
         --LargestContentExtractor	Like DefaultExtractor, but only keeps the largest content block. Good for non-article style texts with only one main content block.
         --KeepEverythingExtractor	Treats everything as "content". Useful to track down SAX parsing errors.
 
         */
        
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
    }
        
        
        detailArticleTitle.text = object["title"]
        if object["author"]!.isEmpty {
            detailArticleAuthor.text = ""
        } else {
            detailArticleAuthor.text = "By " + object["author"]!
        }
        detailArticleDate.text = object["date"]
    
        if let unwrappedDate = object["date"]
        {
            do {
            let formattedDate = try DateInRegion(string: unwrappedDate, format: .iso8601(options: .withInternetDateTime), fromRegion: nil)
            print("formatted date: \(formattedDate)")
            detailArticleDate.text = String(describing: formattedDate)
            } catch {
                print("This is the catch required by DateInRegion, meaning the date couldn't be formatted correctly.")
                }
            }
        
        }

    func switchToWeb() {
        performSegue(withIdentifier: "toWeb", sender: nil)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "toWeb"
        {
            let urlToLoad = object["url"]
                if let destination = segue.destination as? WebViewController
                {
                    destination.url = urlToLoad!
                }
        }
        
    }
}
