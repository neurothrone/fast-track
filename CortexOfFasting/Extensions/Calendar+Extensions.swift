//
//  Calendar+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-12-03.
//

import Foundation

extension Calendar {
  func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
    let fromDate = startOfDay(for: from)
    let toDate = startOfDay(for: to)
    let components = dateComponents([.day], from: fromDate, to: toDate)
    
    return components.day ?? .zero
  }
}
