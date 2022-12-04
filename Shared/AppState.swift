//
//  AppState.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-12-04.
//

import SwiftUI

final class AppState: ObservableObject {
  @AppStorage(Constants.AppStorage.weeklyFastingHoursGoal)
  var weeklyHoursGoal: WeeklyFastingHoursGoal = .easy {
    willSet {
      DispatchQueue.main.async {
        self.objectWillChange.send()
      }
    }
  }
}
