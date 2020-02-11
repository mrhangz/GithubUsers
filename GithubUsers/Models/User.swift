//
//  User.swift
//  GithubUsers
//
//  Created by Teerawat Vanasapdamrong on 10/2/20.
//  Copyright © 2020 mrhangz. All rights reserved.
//

import Foundation

struct User: Codable {
  let login: String
  let id: Int
  let avatarURL: String
  let htmlURL: String
  let type: String
  let siteAdmin: Bool
  
  private enum CodingKeys: String, CodingKey {
    case login
    case id
    case avatarURL = "avatar_url"
    case htmlURL = "html_url"
    case type
    case siteAdmin = "site_admin"
  }
}
