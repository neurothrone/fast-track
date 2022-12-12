//
//  CustomDatePicker.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-16.
//

import SwiftUI

struct CustomDatePicker: View {
  @Binding var selection: Date
  
  let label: String
  let displayMode: DatePickerDisplayMode
  
  var body: some View {
    if displayMode == .compact {
      DatePicker(label, selection: $selection)
        .datePickerStyle(.compact)
    } else {
      Section {
        DatePicker(label, selection: $selection)
          .datePickerStyle(.wheel)
          .labelsHidden()
      } header: {
        Text(label)
      }
    }
  }
}

struct CustomDatePicker_Previews: PreviewProvider {
  static var previews: some View {
    CustomDatePicker(
      selection: .constant(.now),
      label: "Started fasting",
      displayMode: .compact
    )
  }
}
