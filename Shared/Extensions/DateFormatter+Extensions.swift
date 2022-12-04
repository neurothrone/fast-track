//
//  DateFormatter+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import Foundation

extension DateFormatter {
  static var twentyFourHourFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.setLocalizedDateFormatFromTemplate("EEE, MMM d, HH:mm a")
    return formatter
  }()
  
  static var yearFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.dateFormat = "yyyy"
    return formatter
  }()
}
