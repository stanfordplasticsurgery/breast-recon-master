//
//  DocumentationDetailViewController.swift
//  BreastRecon
//
//  Created by Randall Nickerson on 10/29/14.
//  Copyright (c) 2014 Crane Style Labs. All rights reserved.
//

import UIKit

class DocumentationDetailViewController: UIViewController {

    // MARK: - Variables
    var webView: BorderedWebView!
    var urlPath: String?
    var urlRequest: NSURLRequest?

    init(webView: UIWebView) {
        super.init()
        self.webView = webView as BorderedWebView
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    // MARK: - ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        if ((self.webView) == nil) {
            self.webView = BorderedWebView()
        }
    }
    
    // MARK: - Other View Controller Methods
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureWebView() {
        let width = max(view.bounds.size.width, view.bounds.size.height)
        let height = min(view.bounds.size.width, view.bounds.size.height)
        let webframe:CGRect = CGRectMake(0, 0, width, height)
        self.webView.frame = webframe
        self.webView.backgroundColor = UIColor.clearColor()
        self.webView.opaque = false
    }

    func loadRequest(request: NSURLRequest){
        self.webView.loadRequest(request)
    }
    
    func showDefaultHtmlDocument() {
        let defaultHtmlDocument:HtmlDocument = HtmlDocument(filename: "blank.html")
        self.loadRequest(defaultHtmlDocument.getNSURLRequest())
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.webView.stringByEvaluatingJavaScriptFromString("document.open();document.close()")
    }

    // MARK:
}
