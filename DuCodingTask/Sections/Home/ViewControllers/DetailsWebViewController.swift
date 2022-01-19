//
//  DetailsWebViewController.swift
//  DuCodingTask
//
//  Created by Ahmed Shoeib on 8/29/19.
//  Copyright © 2019 Du. All rights reserved.
//


import UIKit
import WebKit

class DetailsWebViewController: BaseViewController {
    
    var urlString : String!
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // show loading
        showLoading(show: true)
        
        // request load webview with url
        if let url = URL(string: urlString) {
            let request = URLRequest(url: url)
            
            webView.navigationDelegate = self
            webView.allowsBackForwardNavigationGestures = true
            webView.load(request)
        }
    }
}

extension DetailsWebViewController: WKNavigationDelegate{
    
    //MARK:- WKNavigationDelegate
    //For Allow SSL https
    func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        showError(message: error.localizedDescription)
        showLoading(show: false)
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showLoading(show: false)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        showLoading(show: false)
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        showError(message: "Failed to load Url \(String(describing: urlString))")
        showLoading(show: false)
    }
    
}

extension DetailsWebViewController: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        // Create new WKWebView with custom configuration here
        let configuration = WKWebViewConfiguration()
        
        return WKWebView(frame: webView.frame, configuration: configuration)
    }
}
