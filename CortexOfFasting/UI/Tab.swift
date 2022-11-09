//
//  Tab.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-09.
//

enum Tab: String {
  case activeWeek = "Active Week"
  case allWeeks = "All Weeks"
  case settings = "Settings"
}

extension Tab: Identifiable, CaseIterable {
  var id: Self { self }
}
