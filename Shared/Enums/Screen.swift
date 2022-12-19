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
    case .activeWeek: return MyApp.SystemImage.activeWeek
    case .allWeeks: return MyApp.SystemImage.allWeeks
    case .settings: return MyApp.SystemImage.settings
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
  func view(withLinearBackground: Bool = true, colorScheme: ColorScheme = .dark) -> some View {
    NavigationStack {
      Group {
        if withLinearBackground {
          self.screen
            .linearBackground(colorScheme: colorScheme)
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
