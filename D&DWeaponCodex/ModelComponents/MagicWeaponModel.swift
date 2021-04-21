//
//  MagicWeaponModel.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 4/20/21.
//  Copyright © 2021 Robert Martin. All rights reserved.
//
// not Finished..still deciding if I want to use a struct for weapons missing stats/info

import Foundation

struct MagicWeaponModel {
  let index: String?
  let name: String?
  // Types
  let equipmentCategory: EquipmentCategory?
  //Sub-Types
  let subCategory: String?
  // misc
  let weaponRange: String?
  let categoryRange: String?
  let damage: Damage?
  let properties: [Properties]?
  let strength: String?
  let stealth: String?
  let range: Range?
  let weight: Float64?
  let cost: Cost?
  let url: String?
  
  init(index: String?, name: String?, equipmentCategory: EquipmentCategory?, subCategory: String?, weaponRange: String?, categoryRange: String?, damage: Damage?, properties: [Properties]?, strength: String?, stealth: String?, range: Range?, weight: Float64, cost: Cost, url: String ){
    self.index = index
    self.name = name
    self.equipmentCategory = equipmentCategory
    self.subCategory = subCategory
    self.weaponRange = weaponRange
    self.categoryRange = categoryRange
    self.damage = damage
    self.properties = properties
    self.strength = strength
    self.stealth = stealth
    self.range = range
    self.weight = weight
    self.cost = cost
    self.url = url
  }
}
