//
//  NetworkRequest.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 12/20/17.
//  Copyright © 2017 Robert Martin. All rights reserved.
//

import Foundation
import UIKit

/*
protocol NetworkRequest: class {
  associatedtype WeaponModel
  func load(withCompletion completion: @escaping (WeaponModel?) -> Void)
  func decode(_ data: Data) -> WeaponModel?
}

extension NetworkRequest {
  fileprivate func load(_ url: URL, withCompletion completion: @escaping (WeaponModel?) -> Void) {
    let configuration = URLSessionConfiguration.ephemeral
    let session = URLSession(configuration: configuration, delegate: nil, delegateQueue: OperationQueue.main)
    let task = session.dataTask(with: url, completionHandler: { [weak self] (data: Data?, response: URLResponse?, error: Error?) -> Void in
      guard let data = data else {
        completion(nil)
        return
      }
      completion(self?.decode(data))
    })
    task.resume()
  }
}




class ImageRequest {
  let url: URL
  
  init(url: URL) {
    self.url = url
  }
}

extension ImageRequest: NetworkRequest {
  func decode(_ data: Data) -> UIImage? {
    return UIImage(data: data)
  }
  
  func load(withCompletion completion: @escaping (UIImage?) -> Void) {
    load(url, withCompletion: completion)
  }
}
*/
