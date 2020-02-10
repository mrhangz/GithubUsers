//
//  UserTableViewController.swift
//  GithubUsers
//
//  Created by Teerawat Vanasapdamrong on 9/2/20.
//  Copyright © 2020 mrhangz. All rights reserved.
//

import UIKit

class UserTableViewController: UITableViewController {
  
  var viewModel: UserTableViewModel!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    viewModel = UserTableViewModel()
    viewModel.didUpdate = { [weak self] in
      self?.tableView.reloadData()
    }
    viewModel.getUsers()
  }
}

