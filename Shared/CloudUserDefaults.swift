//
//  CloudUserDefaults.swift
//  FastTrack
//
//  Created by Zaid Neurothrone on 2022-12-19.
//

import SwiftUI

let isFirstTimeUsingAppKey = "isFirstTimeUsingAppKey"
let weeklyGoalKey = "weeklyGoal"

final class CloudUserDefaults: ObservableObject {
  static var shared: CloudUserDefaults = .init()
  
  @AppStorage(weeklyGoalKey) var weeklyGoal: WeeklyFastingHoursGoal = .easy {
    willSet {
      objectWillChange.send()
    }
    didSet {
      NSUbiquitousKeyValueStore.default.set(weeklyGoal.rawValue, forKey: weeklyGoalKey)
    }
  }
  
  @AppStorage(isFirstTimeUsingAppKey) var isFirstTimeUsingApp: Bool = true {
    willSet {
      objectWillChange.send()
    }
    didSet {
      NSUbiquitousKeyValueStore.default.set(isFirstTimeUsingApp, forKey: isFirstTimeUsingAppKey)
    }
  }
  
  private var keyStore: NSUbiquitousKeyValueStore = .default
  
  private init() {}
  
  //MARK: - Setup
  
  func setUp() {
    UserDefaults.standard.register(defaults: [
      isFirstTimeUsingAppKey: true,
      weeklyGoalKey: WeeklyFastingHoursGoal.easy.rawValue
    ])
    
    registerToEvents()
    
    if NSUbiquitousKeyValueStore.default.synchronize() == false {
      fatalError("❌ -> This app was not built with the proper entitlement requests.")
    }
  }
  
  func registerToEvents() {
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(ubiquitousKeyValueStoreDidChange(_:)),
      name: NSUbiquitousKeyValueStore.didChangeExternallyNotification,
      object: NSUbiquitousKeyValueStore.default)
  }
  
  //MARK: - Persistence
  
  func deleteAllSettings() {
    keyStore.removeObject(forKey: weeklyGoalKey)
    keyStore.removeObject(forKey: isFirstTimeUsingAppKey)
  }
  
  @objc
  func ubiquitousKeyValueStoreDidChange(_ notification: Notification) {
    guard let userInfo = notification.userInfo else { return }
    
    guard let reasonForChange = userInfo[NSUbiquitousKeyValueStoreChangeReasonKey] as? Int else { return }
    
    guard let keys = userInfo[NSUbiquitousKeyValueStoreChangedKeysKey] as? [String] else { return }
    
    // Check if any of the keys we care about were updated, and if so use the new value stored under that key.
    let hasAnyKeyWeCareAbout = keys.contains(weeklyGoalKey) || keys.contains(isFirstTimeUsingAppKey)
    guard hasAnyKeyWeCareAbout else { return }
    
    if reasonForChange == NSUbiquitousKeyValueStoreAccountChange {
      // User changed account, so fall back to UserDefaults
      return
    }
    
    if let weeklyGoalRawValue = keyStore.string(forKey: weeklyGoalKey),
       let weeklyGoal = WeeklyFastingHoursGoal(rawValue: weeklyGoalRawValue) {
      
      DispatchQueue.main.async {
        self.weeklyGoal = weeklyGoal
//        print("✅ -> WeeklyGoal was updated on iCloud. Updating the weeklyGoal of this Device")
      }
      
      return
    }
    
    let isFirstTimeUsingApp = keyStore.bool(forKey: isFirstTimeUsingAppKey)
    if isFirstTimeUsingApp {
      DispatchQueue.main.async {
        self.isFirstTimeUsingApp = false
      }
    }
  }
}

