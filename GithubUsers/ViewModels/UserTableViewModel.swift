//
//  UserTableViewModel.swift
//  GithubUsers
//
//  Created by Teerawat Vanasapdamrong on 10/2/20.
//  Copyright © 2020 mrhangz. All rights reserved.
//

import Foundation

class UserTableViewModel {
  
  private var apiManager: APIManagerProtocol
  private var isLoading = false
  var didUpdate: (() -> Void)?
  private var users: [User] = [] {
    didSet {
      didUpdate?()
    }
  }
  
  init(apiManager: APIManagerProtocol = APIManager()) {
    self.apiManager = apiManager
  }
  
  func getUsers() {
    if isLoading {
      return
    }
    isLoading = true
    let since = users.last?.id ?? 0
    apiManager.getUsers(since: since) { [weak self] result in
      switch result {
      case .success(let users):
        self?.users.append(contentsOf: users)
      case .failure(let error):
        print(error.localizedDescription)
      }
      self?.isLoading = false
    }
  }
}
