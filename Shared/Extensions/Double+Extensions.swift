import Foundation

extension Double {
  func clamped(to value: Double) -> Double {
    self > value ? value : self
  }
}
