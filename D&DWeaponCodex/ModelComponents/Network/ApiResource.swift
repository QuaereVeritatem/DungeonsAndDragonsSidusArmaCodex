//
//  ApiResource.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 12/26/17.
//  Copyright © 2017 Robert Martin. All rights reserved.
//
// this is how you do the API call

import Foundation
/*
protocol ApiResource {
  associatedtype Model
  // the methodPath property it the path of the resource in the URL, for example, /equipment. (for now, were testing with this in as a baseUrl)
  var methodPath: String { get }
  
  // the makeModel(serialization:) method takes a JSON serialization and converts it into the appropriate model value. This type is a generic expressed by the associatedtype
  func makeModel(serialization: Serialization) -> Model
}

extension ApiResource {
  var url: URL {
    let baseUrl = BaseUrl
    // let site = "site=stackoverflow"
    // let order = "order=desc"
    // let sorting = "sort=votes"
    // let tags = "tagged=ios"
    let url = baseUrl
    return URL(string: url)!
  }
  
  func makeModel(data: Data) -> [Model]? {
    guard let json = try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) else {
      return nil
    }
    guard let jsonSerialization = json as? Serialization else {
      return nil
    }
    let wrapper = ApiWrapper(items: [jsonSerialization])
    return wrapper.items.map(makeModel(serialization:))
  }
}

struct ApiCallResource: ApiResource {
  typealias Model = DnDResultAPICall
  
  let methodPath = BaseUrl
  
  func makeModel(serialization: Serialization) -> Model {
    return Model(from: Serialization() as! Decoder)
  }
} */





