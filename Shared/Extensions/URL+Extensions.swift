//
//  URL+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import Foundation

public extension URL {
  /// Returns a URL for the given app group and database pointing to the sqlite database.
  static func storeURL(for appGroup: String, databaseName: String) -> URL {
    guard let fileContainer = FileManager.default.containerURL(
      forSecurityApplicationGroupIdentifier: appGroup) else {
      fatalError("❌ -> Failed to create a shared file container.")
    }
    
    return fileContainer.appendingPathComponent("\(databaseName).sqlite")
  }
}
