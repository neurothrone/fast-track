//
//  Constants.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-11.
//

import Foundation

enum MyApp {
  static let name = "FastTrack"
  
  enum CKConfig {
    static let containerName = "Entities"
    static let sharedAppGroup = "group.fastTrack"
    static let cloudContainerID = "iCloud.fastTrack"
  }
  
  enum SystemImage {
    static let activeWeek = "clock"
    static let allWeeks = "calendar"
    static let settings = "gear"

    static let startClock = "clock.badge.checkmark"
    static let stopClock = "clock.badge.xmark"
    static let resetClock = "clock.arrow.circlepath"
    
    static let checkmark = "checkmark"
    static let target = "target"
    static let gauge = "gauge"
  }
  
  enum AppStorage {
    static let selectedScreen = "selectedScreen"
    static let datePickerDisplayMode = "datePickerDisplayMode"
    static let weeklyFastingHoursGoal = "weeklyFastingHoursGoal"
    static let isOnboardingPresented = true
    static let columnVisibility = "columnVisibility"
  }
  
  enum Link {
    static let svgRepo = "https://www.svgrepo.com/"
  }
}
