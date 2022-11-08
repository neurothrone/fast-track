//
//  Date+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-08.
//

import Foundation

extension Date {
  func adding(minutes: Int) -> Date {
    Calendar.current.date(byAdding: .minute, value: minutes, to: self) ?? .now
  }
  
  func adding(hours: Int) -> Date {
    Calendar.current.date(byAdding: .hour, value: hours, to: self) ?? .now
  }
  
  func subtracting(minutes: Int) -> Date {
    adding(minutes: -minutes)
  }
  
  func subtracting(hours: Int) -> Date {
    adding(hours: -hours)
  }
  
  func duration(to laterDate: Date) -> TimeInterval {
    self.distance(to: laterDate)
  }
}
