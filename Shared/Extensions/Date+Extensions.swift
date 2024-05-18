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
  
  var inReadableFormat: String {
    DateFormatter.twentyFourHourFormatter.string(from: self)
  }
  
  func startOfWeek(using calendar: Calendar = Calendar.current) -> Date {
    calendar.dateComponents([.calendar, .yearForWeekOfYear, .weekOfYear], from: self).date!
  }
  
  var year: String {
    DateFormatter.yearFormatter.string(from: self)
  }
}
