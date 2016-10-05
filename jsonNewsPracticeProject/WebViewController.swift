//
//  WebViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 10/4/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit

class WebViewController: UIViewController {


    var object = String()
    
    @IBOutlet weak var WebView: UIWebView!
    @IBOutlet weak var articleWebsite: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("ABC: \(object)")
        
//        let myUrl = NSURL(string: "https://google.com")
//        let requestObj = URLRequest(url: myUrl as! URL)
//        articleWebsite.loadRequest(requestObj)
//        print(myUrl)
        // Do any additional setup after loading the view.
    }
    
        
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
