//
//  UserTableViewCell.swift
//  GithubUsers
//
//  Created by Teerawat Vanasapdamrong on 11/2/20.
//  Copyright © 2020 mrhangz. All rights reserved.
//

import UIKit

class UserTableViewCell: UITableViewCell {
  private var viewModel: UserCellViewModel?
  @IBOutlet private var avartarImageView: UIImageView!
  @IBOutlet private var loginLabel: UILabel!
  @IBOutlet private var githubURLLabel: UILabel!
  @IBOutlet private var accountTypeLabel: UILabel!
  @IBOutlet private var adminStatusLabel: UILabel!
  @IBOutlet private var favoriteButton: UIButton!
  
  func displayCell(viewModel: UserCellViewModel) {
    self.viewModel = viewModel
    loginLabel.text = viewModel.login
    githubURLLabel.text = viewModel.url
    accountTypeLabel.text = viewModel.accountType
    adminStatusLabel.text = viewModel.siteAdmin
    viewModel.getAvatar { [weak self] image in
      self?.avartarImageView.image = image
    }
    favoriteButton.isSelected = viewModel.isFavorite
  }
  
  @IBAction private func favoriteTapped(sender: UIButton) {
    sender.isSelected = !sender.isSelected
    viewModel?.setFavorite(isFavorite: sender.isSelected)
  }
}
