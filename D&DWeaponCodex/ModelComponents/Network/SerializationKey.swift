//
//  SerializationKey.swift
//  D&DWeaponCodex
//
//  Created by Robert Martin on 12/26/17.
//  Copyright © 2017 Robert Martin. All rights reserved.
//

import Foundation

typealias Serialization = [String: Any]

protocol SerializationKey {
  var stringValue: String { get }
}

extension RawRepresentable where RawValue == String {
  var stringValue: String {
    return rawValue
  }
}

protocol SerializationValue {}

extension Bool: SerializationValue {}
extension String: SerializationValue {}
extension Int: SerializationValue {}
extension Dictionary: SerializationValue {}
extension Array: SerializationValue {}

extension Dictionary where Key == String, Value: Any {
  func value<V: SerializationValue>(forKey key: SerializationKey) -> V? {
    return self[key.stringValue] as? V
  }
}
