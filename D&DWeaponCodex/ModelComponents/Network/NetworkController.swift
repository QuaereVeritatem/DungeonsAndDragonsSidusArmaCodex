//
//  NetworkController.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 12/20/17.
//  Copyright © 2017 Robert Martin. All rights reserved.
//

import Foundation

class NetworkController1 {
  func loadQuestions(withCompletion completion: @escaping ([WeaponModel]?) -> Void) {
    let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
    let url = URL(string: BaseUrl)!
    let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
      guard let data = data else {
        completion(nil)
        return
      }
      guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
        completion(nil)
        return
      }
      let weapon: [WeaponModel] = [] // Transform JSON into Weapon values
      completion(weapon)
    })
    task.resume()
  }
}

class NetworkController {
  static let questionsURL = BaseUrl
  static let usersURL = BaseUrl
  
  func load(_ urlString: String, withCompletion completion: @escaping ([Any]?) -> Void) {
    let session = URLSession(configuration: .ephemeral, delegate: nil, delegateQueue: OperationQueue.main)
    let url = URL(string: urlString)!
    let task = session.dataTask(with: url, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
      guard let data = data else {
        completion(nil)
        return
      }
      guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
        completion(nil)
        return
      }
      let result: [Any]
      switch urlString {
      case NetworkController.questionsURL:
        result = [] // Transform JSON into Question values
      case NetworkController.usersURL:
        result = [] // Transform JSON into Question values
      default:
        result = []
      }
      completion(result)
    })
    task.resume()
  }
}
