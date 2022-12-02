//
//  WeeklyFastingHoursGoal.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-17.
//

enum WeeklyFastingHoursGoal: String {
  case easy
  case normal
  case hard
  case legendary
  case mythic
  case insanity
}

extension WeeklyFastingHoursGoal: Identifiable, CaseIterable, Codable {
  var id: Self { self }
  
  var hours: Int {
    switch self {
    case .easy:
      return 12
    case .normal:
      return 16
    case .hard:
      return 20
    case .legendary:
      return 24
    case .mythic:
      return 32
    case .insanity:
      return 48
    }
  }
  
  var toString: String {
    "\(rawValue.capitalized) (\(hours))"
  }
}
