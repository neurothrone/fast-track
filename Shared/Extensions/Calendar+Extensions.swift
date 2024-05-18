import Foundation

extension Calendar {
  func numberOfDaysBetween(_ from: Date, and to: Date) -> Int {
    let fromDate = startOfDay(for: from)
    let toDate = startOfDay(for: to)
    let components = dateComponents([.day], from: fromDate, to: toDate)
    
    return components.day ?? .zero
  }
}
