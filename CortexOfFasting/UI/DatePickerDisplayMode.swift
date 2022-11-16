//
//  DatePickerDisplayMode.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-16.
//

import Foundation

enum DatePickerDisplayMode: String {
  case compact = "Compact"
  case wheel = "Wheel"
}

extension DatePickerDisplayMode: Identifiable, CaseIterable {
  var id: Self { self }
}
