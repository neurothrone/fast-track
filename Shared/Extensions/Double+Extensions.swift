//
//  Double+Extensions.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-12.
//

import Foundation

extension Double {
  func clamped(to value: Double) -> Double {
    self > value ? value : self
  }
}
