//
//  ParsingJSON.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 12/19/17.
//  Copyright © 2017 Robert Martin. All rights reserved.
//
// TODO List: 1) catch errors and sed them to error folder/file

import Foundation

let jsonDecoder = JSONDecoder()
let weapon = try? jsonDecoder.decode(WeaponModel.self, from: jsonData)
//var container = encoder.container(keyedBy: CodingKeys.self)
