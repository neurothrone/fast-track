//
//  ProgressMeterView.swift
//  CortexOfFasting
//
//  Created by Zaid Neurothrone on 2022-11-09.
//

import SwiftUI

struct ProgressMeterView: View {
  let label: String
  let systemImage: String
  
  let amount: Double
  let min: Double
  let max: Double
  
  var body: some View {
    VStack {
      Gauge(value: amount, in: 0...24) {
        Label(label, systemImage: systemImage)
      } currentValueLabel: {
        Text(amount.formatted(.number))
          .foregroundColor(.purple)
      } minimumValueLabel: {
        Text(min.formatted(.number))
      } maximumValueLabel: {
        Text(max.formatted(.number))
      }
      .font(.headline)
      .textCase(.none)
      .tint(.purple)
    }
  }
}

struct ProgressMeterView_Previews: PreviewProvider {
  static var previews: some View {
    ProgressMeterView(
      label: "Fasted state hours this week",
      systemImage: "gauge",
      amount: 12.1,
      min: .zero,
      max: 24
    )
  }
}
