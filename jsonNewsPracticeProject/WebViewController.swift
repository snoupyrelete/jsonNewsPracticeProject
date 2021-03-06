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


    var url = String()
    
    var webView: WKWebView!
    
    @IBOutlet weak var progressView: UIProgressView!
   
    @IBAction func reload(sender: UIBarButtonItem) {
        webView.reload()
    }
    
    @IBAction func back(sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func forward(sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let progressView = UIProgressView(progressViewStyle: .default)
        progressView.sizeToFit()
        
        WebViewController.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
        
        navigationController!.isToolbarHidden = false
        
        navigationController!.toolbar.setItems(toolbarItems, animated: true)
        let myURL = URL(string: url)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        self.title = "Web View"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        
        
    }
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        navigationController!.title = "LOADING"
    }
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        navigationController!.title = "DONE"
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progressView.progress = Float(webView.estimatedProgress)
        }
    }
    
    func shareButtonTapped() {
        
        let sentFrom = "\n--Sent from Daily Read iOS app."
        let vc = UIActivityViewController(activityItems: [webView.url!, sentFrom], applicationActivities: [])
        vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
                present(vc, animated: true)
    }
}
