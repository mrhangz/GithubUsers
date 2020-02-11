//
//  UserCellViewModel.swift
//  GithubUsers
//
//  Created by Teerawat Vanasapdamrong on 11/2/20.
//  Copyright © 2020 mrhangz. All rights reserved.
//

import UIKit

struct UserCellViewModel {
  var user: User
  var apiManager: APIManagerProtocol
  
  init(user: User, apiManager: APIManagerProtocol = APIManager()) {
    self.user = user
    self.apiManager = apiManager
  }
  
  var login: String {
    return "Login: \(user.login)"
  }
  
  var url: String {
    return user.htmlURL
  }
  
  var accountType: String {
    return "Type: \(user.type)"
  }
  
  var siteAdmin: String {
    return "Admin: \(user.siteAdmin ? "Yes" : "No")"
  }
  
  var isFavorite: Bool {
    return FavoriteManager.shared.checkFavorite(id: user.id)
  }
  
  var userID: Int {
    return user.id
  }
  
  func getAvatar(_ completion: @escaping (UIImage) -> Void) {
    apiManager.getImage(path: user.avatarURL) { image in
      completion(image)
    }
  }
  
  func setFavorite(isFavorite: Bool) {
    if isFavorite {
      FavoriteManager.shared.addFavorite(id: userID)
    } else {
      FavoriteManager.shared.removeFavorite(id: userID)
    }
  }
}
