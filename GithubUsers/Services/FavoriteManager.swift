//
//  FavoriteManager.swift
//  GithubUsers
//
//  Created by Teerawat Vanasapdamrong on 12/2/20.
//  Copyright © 2020 mrhangz. All rights reserved.
//

import Foundation

class FavoriteManager {
  
  static let shared = FavoriteManager()
  private init() {
    if let decoded = UserDefaults.standard.object(forKey: "favorites") as? Data,
      let favorites = NSKeyedUnarchiver.unarchiveObject(with: decoded) as? Set<Int> {
      self.favorites = favorites
    } else {
      favorites = []
    }
  }
  private var favorites: Set<Int>
  
  func addFavorite(id: Int) {
    favorites.insert(id)
    saveFavorites()
  }
  
  func removeFavorite(id: Int) {
    favorites.remove(id)
    saveFavorites()
  }
  
  func checkFavorite(id: Int) -> Bool {
    favorites.contains(id)
  }
  
  private func saveFavorites() {
    let encodedData = NSKeyedArchiver.archivedData(withRootObject: favorites)
    UserDefaults.standard.set(encodedData, forKey: "favorites")
  }
}
