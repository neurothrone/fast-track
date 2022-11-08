//
//  ContentView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import SwiftUI

enum Tab: String {
  case activeWeek = "Active Week"
  case allWeeks = "All Weeks"
  case settings = "Settings"
}

extension Tab: Identifiable, CaseIterable {
  var id: Self { self }
}

private extension Tab {
  @ViewBuilder
  var view: some View {
    switch self {
    case .activeWeek:
      ActiveWeekScreen()
    case .allWeeks:
      AllWeeksScreen()
    case .settings:
      SettingsScreen()
    }
  }
  
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
}

struct ContentView: View {
  @AppStorage("selectedTab")
  var selectedTab: Tab = .activeWeek
  
  var body: some View {
    TabView(selection: $selectedTab) {
      ForEach(Tab.allCases) { tab in
        tab.view
          .tabItem {
            Label(tab.rawValue, systemImage: tab.systemImage)
          }
      }
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
