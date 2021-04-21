//
//  WeaponListModel.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 3/7/21.
//  Copyright © 2021 Robert Martin. All rights reserved.
//

import Foundation

struct WeaponListModel: Codable {
  let index: String
  let name: String?
  let equipment: [Equipment]
  let url: String
 
  init(index: String, name: String?, equipment: [Equipment], url: String ){
    self.index = index
    self.name = name
    self.equipment = equipment
    self.url = url
  }

  enum CodingKeys: String, CodingKey {
    case index = "index"
    case name = "name"
    case equipment = "equipment"
    case url = "url"
  }


struct Equipment: Codable {
  let index: String
  let name: String
  let url: String
  
  init(index: String, name: String, url: String ){
    self.index = index
    self.name = name
    self.url = url
  }
  
  enum CodingKeys: String, CodingKey {
    case index = "index"
    case name = "name"
    case url = "url"
  }
}
}
