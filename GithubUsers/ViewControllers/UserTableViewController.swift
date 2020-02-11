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
    viewModel.didFail = { [weak self] error in
      let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
      let action = UIAlertAction(title: "OK", style: .destructive)
      alert.addAction(action)
      self?.present(alert, animated: true, completion: nil)
    }
    viewModel.getUsers()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let url = sender as? String, let destination = segue.destination as? UserViewController {
      destination.githubURL = url
    }
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.userCount
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell else {
      return UITableViewCell()
    }
    cell.displayCell(viewModel: viewModel.getUser(at: indexPath.row))
    return cell
  }
  
  override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    if indexPath.row == viewModel.userCount - 10 {
      viewModel.getUsers()
    }
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    performSegue(withIdentifier: "UserVC", sender: viewModel.urlForUser(at: indexPath.row))
  }
}
