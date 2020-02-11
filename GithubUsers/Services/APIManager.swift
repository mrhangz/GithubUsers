//
//  APIManager.swift
//  GithubUsers
//
//  Created by Teerawat Vanasapdamrong on 10/2/20.
//  Copyright © 2020 mrhangz. All rights reserved.
//

import Foundation
import UIKit

enum APIError: Error {
  case invalidRequest
  case invalidJSON
  case serviceError
}

protocol APIManagerProtocol {
  func getUsers(since: Int, _ completion: @escaping (Result<[User], APIError>) -> Void)
  func getImage(path: String, _ completion: @escaping (UIImage) -> Void)
}

let baseURL: String = "https://api.github.com"

var imageCache = NSCache<NSString, UIImage>()

class APIManager {
  private func request<T: Codable>(urlString: String, httpMethod:
    String = "GET", completion: @escaping (Result<T, APIError>) -> Void) {
    guard let url = URL(string: urlString) else {
      return
    }
    var request = URLRequest(url: url)
    request.timeoutInterval = 10
    request.httpMethod = httpMethod
    let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
      if let _ = error {
        completion(.failure(.invalidRequest))
      } else if let data = data, let response = response as? HTTPURLResponse {
        if response.statusCode == 200 {
          do {
            let values = try JSONDecoder().decode(T.self, from: data)
            DispatchQueue.main.async {
              completion(.success(values))
            }
          } catch {
            DispatchQueue.main.async {
              completion(.failure(.invalidJSON))
            }
          }
        } else {
          DispatchQueue.main.async {
            completion(.failure(.serviceError))
          }
        }
      }
    }
    task.resume()
  }
}

extension APIManager: APIManagerProtocol {
  func getUsers(since: Int, _ completion: @escaping (Result<[User], APIError>) -> Void) {
    request(urlString: "\(baseURL)/users?since=\(since)", completion: completion)
  }
  
  func getImage(path: String, _ completion: @escaping (UIImage) -> Void) {
    if let image = imageCache.object(forKey: path as NSString) {
      completion(image)
    } else if let url = URL(string: path) {
      DispatchQueue.global().async {
        if let data = try? Data(contentsOf: url) {
          if let image = UIImage(data: data) {
            DispatchQueue.main.sync {
              imageCache.setObject(image, forKey: path as NSString)
              completion(image)
            }
          }
        }
      }
    }
  }
}
