//
//  Constants.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-11.
//

import Foundation

struct CKConfig {
  private init() {}
  
  static let containerName = "Entities"
  static let sharedAppGroup = "group.fastTrack"
  static let cloudContainerID = "iCloud.fastTrack"
}

enum Constants {
  struct App {
    static let name = "FastTrack"
  }
  
  struct SystemImage {
    static let activeWeek = "clock"
    static let allWeeks = "calendar"
    static let settings = "gear"

    static let startClock = "clock.badge.checkmark"
    static let stopClock = "clock.badge.xmark"
    static let resetClock = "clock.arrow.circlepath"
  }
  
  struct AppStorage {
    static let selectedScreen = "selectedScreen"
    static let datePickerDisplayMode = "datePickerDisplayMode"
    static let weeklyFastingHoursGoal = "weeklyFastingHoursGoal"
    static let isOnboardingPresented = true
  }
  
  struct Link {
    static let svgRepo = "https://www.svgrepo.com/"
  }
}
