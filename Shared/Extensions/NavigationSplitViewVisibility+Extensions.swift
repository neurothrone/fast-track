//
//  NavigationSplitViewVisibility+Extensions.swift
//  FastTrack iOS App
//
//  Created by Zaid Neurothrone on 2022-12-12.
//

import SwiftUI

// RawRepresentable conformance so it can be used with AppStorage
extension NavigationSplitViewVisibility: RawRepresentable {
  public init?(rawValue: String) {
    guard let data = rawValue.data(using: .utf8),
          let result = try? JSONDecoder().decode(Self.self, from: data)
    else { return nil }
    
    self = result
  }
  
  public var rawValue: String {
    guard let data = try? JSONEncoder().encode(self),
          let result = String(data: data, encoding: .utf8)
    else { return "[]" }
    
    return result
  }
}
