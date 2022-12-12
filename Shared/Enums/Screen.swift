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
      return Constants.SystemImage.activeWeek
    case .allWeeks:
      return Constants.SystemImage.allWeeks
    case .settings:
      return Constants.SystemImage.settings
    }
  }
  
  @ViewBuilder
  var screen: some View {
    switch self {
    case .activeWeek:
      ActiveWeekScreen()
    case .allWeeks:
      AllWeeksScreen()
    case .settings:
      SettingsScreen()
    }
  }

#if os(iOS)
  func view(withLinearBackground: Bool = true) -> some View {
    NavigationStack {
      Group {
        if withLinearBackground {
          self.screen
            .linearBackground()
        } else {
          self.screen
        }
      }
      .navigationTitle(self.rawValue)
      .navigationBarTitleDisplayMode(.inline)
    }
  }
#endif
  
#if os(macOS)
  static var allForMac: [Screen] {
    Screen.allCases.filter { $0 != .settings }
  }
#endif
}
