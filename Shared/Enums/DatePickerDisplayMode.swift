import Foundation

enum DatePickerDisplayMode: String {
  case compact = "Compact"
  case wheel = "Wheel"
}

extension DatePickerDisplayMode: Identifiable, CaseIterable {
  var id: Self { self }
}
