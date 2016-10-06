//
//  WebViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 10/4/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate {


    var object = String()
    
    @IBOutlet weak var articleWebView: UIWebView!
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let url = URL(string: object)
//        articleWebView.loadRequest(URLRequest(url: url!))
        let myURL = URL(string: object)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        self.title = "Hello"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
    }
    
    func shareTapped() {
        
        let string = "adsadasdafsgadfghjfgdsfsgh"
        let url = NSURL(string: "https://www.google.com")
        let test = NSString(string: object)
        
        let vc = UIActivityViewController(activityItems: [string, url], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        present(vc, animated: true)
    }
    
        
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
