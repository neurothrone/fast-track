//
//  Screen.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-09.
//

import SwiftUI

enum Screen: String {
  case activeWeek = "Active Week"
  case allWeeks = "All Weeks"
  case settings = "Settings"
}

extension Screen: Identifiable, CaseIterable {
  var id: Self { self }
  
  var systemImage: String {
    switch self {
    case .activeWeek:
      return "clock"
    case .allWeeks:
      return "calendar"
    case .settings:
      return "gear"
    }
  }
  
  var view: some View {
    NavigationStack {
      self.screen
        .linearBackground()
        .navigationTitle(self.rawValue)
        .navigationBarTitleDisplayMode(.inline)
    }
  }
  
  @ViewBuilder
  private var screen: some View {
    switch self {
    case .activeWeek:
      ActiveWeekScreen()
    case .allWeeks:
      AllWeeksScreen()
    case .settings:
      SettingsScreen()
    }
  }
}
