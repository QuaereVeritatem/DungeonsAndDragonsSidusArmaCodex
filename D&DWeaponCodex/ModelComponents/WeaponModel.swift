//
//  WeaponModel.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 12/19/17.
//  Copyright © 2017 Robert Martin. All rights reserved.
//
// Resource used to make this model can be found at http://www.dnd5eapi.co/docs/#equipment-weapons

// update all models to reflect the attributes of Struct EquipmentModel

import Foundation

struct DnDResultAPICall: Codable {
  let count: IntegerLiteralType
  let results: [EquipmentModel]

  init(count: IntegerLiteralType, results: [EquipmentModel]){
    self.count = count
    self.results = results
  }

  enum CodingKeys: String, CodingKey {
    case count = "count"
    case results = "results"
  }
}

struct WeaponModel: Codable {
  let id: String
  let index: IntegerLiteralType
  let name: String
  let type: String
  let subType: String
  let weaponRange: String
  let weaponCategory: String
  let cost: Cost
  let damage: Damage
  let weight: Float64
  let properties: [String]
  let url: String
 
  init(id: String, index: IntegerLiteralType, name: String, type: String,
       subType: String, weaponRange: String, weaponCategory: String,
       cost: Cost, damage: Damage, weight: Float64, properties: [String],
       url: String ){
    self.id = id
    self.index = index
    self.name = name
    self.type = type
    self.subType = subType
    self.weaponRange = weaponRange
    self.weaponCategory = weaponCategory
    self.cost = cost
    self.damage = damage
    self.weight = weight
    self.properties = properties
    self.url = url
  }

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case index = "index"
    case name = "name"
    case type = "type"
    case subType = "subType"
    case weaponRange = "weapon_range"
    case weaponCategory = "weapon_category"
    case cost = "cost"
    case damage = "damage"
    case weight = "weight"
    case properties = "properties"
    case url = "url"
  }
}

struct Cost: Codable {
  let quantity: IntegerLiteralType
  let unit: String
 
  init(quantity: IntegerLiteralType, unit: String){
    self.quantity = quantity
    self.unit = unit
  }
 
  enum CodingKeys: String, CodingKey {
    case quantity = "quantity"
    case unit = "unit"
  }
}

struct Damage: Codable {
  let diceCount: IntegerLiteralType
  let diceValue: IntegerLiteralType
  let damageType: DamageType

  init(diceCount: IntegerLiteralType, diceValue: IntegerLiteralType, damageType: DamageType){
    self.diceCount = diceCount
    self.diceValue = diceValue
    self.damageType = damageType
  }

  enum CodingKeys: String, CodingKey {
    case diceCount = "dice_count"
    case diceValue = "dice_value"
    case damageType = "damage_type"
  }
}

struct DamageType: Codable {
  let url: String
  let name: String

  init(url: String, name: String){
    self.url = url
    self.name = name
  }
 
  enum CodingKeys: String, CodingKey {
    case url = "url"
    case name = "name"
  }
}

struct ArmorModel: Codable {
  let id: String
  let index: IntegerLiteralType
  let name: String
  let type: String
  let subType: String
  let armorClass: ArmorClass
  let strength: String
  let stealth: String
  let weight: Float64
  let cost: Cost
  let url: String

  init(id: String, index: IntegerLiteralType, name: String, type: String, subType: String, armorClass: ArmorClass, strength: String, stealth: String, weight: Float64, cost: Cost, url: String){
    self.id = id
    self.index = index
    self.name = name
    self.type = type
    self.subType = subType
    self.armorClass = armorClass
    self.strength = strength
    self.stealth = stealth
    self.weight = weight
    self.cost = cost
    self.url = url
  }

  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case index = "index"
    case name = "name"
    case type = "type"
    case subType = "subtype"
    case armorClass = "armor_class"
    case strength = "strength"
    case stealth = "stealth"
    case weight = "weight"
    case cost = "cost"
    case url = "url"
  }
}

struct ArmorClass: Codable {
  let base: IntegerLiteralType
  let dex_bonus: Bool
  let max_bonus: IntegerLiteralType

  init(base: IntegerLiteralType, dex_bonus: Bool, max_bonus: IntegerLiteralType){
    self.base = base
    self.dex_bonus = dex_bonus
    self.max_bonus = max_bonus
  }
 
  enum CodingKeys: String, CodingKey {
    case base = "base"
    case dex_bonus = "dex_bonus"
    case max_bonus = "max_bonus"
  }
}

struct Properties: Codable {
  let name: String
  let url: String
 
  init(url: String, name: String){
    self.name = name
    self.url = url
  }
  
  enum CodingKeys: String, CodingKey {
    case name = "name"
    case url = "url"
  }
}

// EquipmentModel will handle both Armor and Weapons
struct EquipmentModel: Codable {
  let id: String?
  let index: IntegerLiteralType?
  let name: String
  // Types
  let equipmentCategory: String?
  //Sub-Types
  let weaponCategory: String?  
  let armorCategory: String?
  let gearCategory: String?
  let toolCategory: String?
  let vehicleCategory: String?
  // misc
  let weaponRange: String?
  let categoryRange: String?
  let armorClass: ArmorClass?
  let damage: Damage?
  let properties: [Properties]?
  let strength: String?
  let stealth: String?
  let weight: Float64?
  let cost: Cost?
  let url: String?
  
  init(id: String?, index: IntegerLiteralType?, name: String, equipmentCategory: String?, weaponCategory: String?, armorCategory: String?, gearCategory: String?, toolCategory: String?, vehicleCategory: String?, weaponRange: String?, categoryRange: String?, armorClass: ArmorClass?, damage: Damage?, properties: [Properties]?, strength: String?, stealth: String?, weight: Float64, cost: Cost, url: String ){
    self.id = id
    self.index = index
    self.name = name
    self.equipmentCategory = equipmentCategory
    self.weaponCategory = weaponCategory
    self.armorCategory = armorCategory
    self.gearCategory = gearCategory
    self.toolCategory = toolCategory
    self.vehicleCategory = vehicleCategory
    self.weaponRange = weaponRange
    self.categoryRange = categoryRange
    self.armorClass = armorClass
    self.damage = damage
    self.properties = properties
    self.strength = strength
    self.stealth = stealth
    self.weight = weight
    self.cost = cost
    self.url = url
  }
 
  enum CodingKeys: String, CodingKey {
    case id = "_id"
    case index = "index"
    case name = "name"
    case equipmentCategory = "equipment_category"
    // DandD API F**ked up and typed their category as "weapon_category:" (yes, they included :)
    case weaponCategory = "weapon_category:"
    case armorCategory = "armor_category"
    case gearCategory = "gear_category"
    case toolCategory = "tool_category"
    case vehicleCategory = "vehicle_category"
    case weaponRange = "weapon_range"
    case categoryRange = "category_range"
    case armorClass = "armor_class"
    case damage = "damage"
    case properties = "properties"
    case strength = "strength"
    case stealth = "stealth"
    case weight = "weight"
    case cost = "cost"
    case url = "url"
  }
}


