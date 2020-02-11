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
  var didFail: ((Error) -> Void)?
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
        self?.didFail?(error)
      }
      self?.isLoading = false
    }
  }
  
  var userCount: Int {
    return users.count
  }
  
  func getUser(at index: Int) -> UserCellViewModel {
    return UserCellViewModel(user: users[index])
  }
  
  func urlForUser(at index: Int) -> String {
    return users[index].htmlURL
  }
}
