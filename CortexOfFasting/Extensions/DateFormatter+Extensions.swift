//
//  DateFormatter+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import Foundation

extension DateFormatter {
  static var deviceLocaleFormatter: DateFormatter {
    let formatter = DateFormatter()
    formatter.locale = .current
    formatter.setLocalizedDateFormatFromTemplate("dd MMMM YY HH:mm")
    return formatter
  }
}
