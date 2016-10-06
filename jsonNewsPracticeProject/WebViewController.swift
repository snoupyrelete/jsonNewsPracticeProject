//
//  WebViewController.swift
//  jsonNewsPracticeProject
//
//  Created by Dylan Robson on 10/4/16.
//  Copyright © 2016 Dylan Robson. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {


    var object = String()
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        let toolbarItems = [UIBarButtonItem(image: #imageLiteral(resourceName: "Domain"), style: UIBarButtonItemStyle.plain, target: self, action: nil), UIBarButtonItem(image: #imageLiteral(resourceName: "Domain"), style: UIBarButtonItemStyle.plain, target: self, action: nil)]
        
        navigationController!.isToolbarHidden = false
        
        navigationController!.toolbar.setItems(toolbarItems, animated: true)
//        let url = URL(string: object)
//        articleWebView.loadRequest(URLRequest(url: url!))
        let myURL = URL(string: object)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        self.title = "Web View"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareTapped))
        
        
    }
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        self.title = "LOADING"
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.title = "DONE"
    }
    
    func shareTapped() {
        
        let sentFrom = "\n--Sent from Dylan's JSON News app."
        //var sharingItems: [Any?] = [url, string, test]
        
        let vc = UIActivityViewController(activityItems: [webView.url!, sentFrom], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        //vc.excludedActivityTypes = [UIActivityTypeReminder]
        present(vc, animated: true)
    }
    
        
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
