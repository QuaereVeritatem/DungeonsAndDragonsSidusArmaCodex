//
//  CodableBundleExtension.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 3/13/21.
//  Copyright © 2021 Robert Martin. All rights reserved.
//

import Foundation

extension Bundle {
  func decode(_ file: String) -> [String] {
    // 1. Locate the json file..this will be url for the weapon details website
    guard let url = self.url(forResource: file, withExtension: nil) else {
      fatalError("Failed to LOCATE \(file) in bundle")
    }
    
    // 2. Create a property for the data
    guard let data = try? Data(contentsOf: url) else {
      fatalError("Failed to LOAD \(file) from bundle")
    }
    
    // 3. Create a decoder
    let decoder = JSONDecoder()
    
    // 4. Create a property for the decoded data
    guard let loaded = try? decoder.decode([String].self, from: data) else {
      fatalError("Failed to DECODE \(file) from bundle")
    }
    
    // 5. Return the ready-to-use data
    return loaded
  }
}
