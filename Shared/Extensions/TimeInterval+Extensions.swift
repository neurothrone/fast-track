import Foundation

extension TimeInterval {
  struct Formatter {
    static let hourAndMinFormatter: DateComponentsFormatter = {
      let formatter = DateComponentsFormatter()
      formatter.allowedUnits = [.hour, .minute]
      formatter.unitsStyle = .abbreviated
      return formatter
    }()
    
    static let inHoursAndMinsDigitalClockStyleFormatter: DateComponentsFormatter = {
      let formatter = DateComponentsFormatter()
      formatter.allowedUnits = [.hour, .minute, .second]
      formatter.unitsStyle = .positional
      formatter.zeroFormattingBehavior = .pad
      return formatter
    }()
  }
  
  var inHoursAndMinutes: String {
    guard !self.isNaN,
          !self.isInfinite,
          let string = Formatter.hourAndMinFormatter.string(from: self)
    else { return "" }
    return string
  }
  
  var inHoursAndMinutesDigitalClockStyle: String {
    guard !self.isNaN,
          !self.isInfinite,
          let string = Formatter.inHoursAndMinsDigitalClockStyleFormatter.string(from: self)
    else { return "" }
    return string
  }
}
