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
    @IBOutlet weak var detailArticleDescription: UILabel!
    @IBOutlet weak var detailArticleURL: UILabel!
    
   // var objects = [[String: String]]()
    var object = [String: String]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBarHidden = false
        
        //print("objects in dvc: \(objects)")
        
        //let object = objects[indexPath.row]

        
        detailArticleTitle.text = object["title"]
       // detailArticleSource.text = object["source"]
        detailArticleAuthor.text = "By" + object["author"]!
        detailArticleDescription.text = object["description"]
        detailArticleDate.text = object["date"]
        detailArticleURL.text = object["url"]


        // Do any additional setup after loading the view.
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

}
