//
//  WebPageViewController.swift
//  Project16
//
//  Created by David Bochenski on 24/08/2019.
//  Copyright © 2019 Go Incremental. All rights reserved.
//

import UIKit
import WebKit

class WebPageViewController: UIViewController, WKNavigationDelegate {
    @IBOutlet var webView: WKWebView!
    
    var selectedPage: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL(string: "https://" + selectedPage!)!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = false
        
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        webView.navigationDelegate = self
    }

    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
    
}
