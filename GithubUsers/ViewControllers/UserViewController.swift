//
//  UserViewController.swift
//  GithubUsers
//
//  Created by Teerawat Vanasapdamrong on 11/2/20.
//  Copyright © 2020 mrhangz. All rights reserved.
//

import UIKit
import WebKit

class UserViewController: UIViewController {
  
  @IBOutlet private var webView: WKWebView!
  var githubURL: String!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let url = URL(string: githubURL) {
      let request = URLRequest(url: url)
      webView.load(request)
    }
  }
}
