//
//  DataManager.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-12.
//

import CoreData
import Foundation

final class DataManager: ObservableObject {
  static let shared: DataManager = .init()
  
  @Published var isTimerRunning = false
  
  private init() {}
  
  func deleteAllData(using context: NSManagedObjectContext) {
    FastLog.deleteAll(using: context)
    
    isTimerRunning = false
  }
}
