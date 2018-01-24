//
//  GetThatJSON.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 12/19/17.
//  Copyright © 2017 Robert Martin. All rights reserved.
//
// This file will simply go out and connect with the API Base URL to grab data (no parsing here)

import Foundation

let sampleDataAddress = BaseUrl
let url = URL(string: sampleDataAddress)! 
let jsonData = try! Data(contentsOf: url)
