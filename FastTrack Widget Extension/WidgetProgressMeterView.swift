//
//  WidgetProgressMeterView.swift
//  FastTrack Widget Extension
//
//  Created by Zaid Neurothrone on 2022-12-17.
//

import SwiftUI
import WidgetKit

struct WidgetProgressMeterView: View {
  let label: String
  let systemImage: String
  
  let amount: Double
  let min: Double
  let max: Double
  
  let progressColor: Color
  
  var body: some View {
    VStack {
      Gauge(value: amount.clamped(to: max), in: min...max) {
        Label(label, systemImage: systemImage)
          .foregroundColor(.secondary)
      } currentValueLabel: {
        Text(amount.formatted(.number))
          .font(.headline)
          .fontWeight(.heavy)
          .foregroundColor(.purple)
          .frame(maxWidth: .infinity, alignment: .center)
      } minimumValueLabel: {
        Text(min.formatted(.number))
      } maximumValueLabel: {
        Text(max.formatted(.number))
      }
      .textCase(.none)
      .tint(progressColor)
      .gaugeStyle(.accessoryCircular)
    }
  }
}

struct WidgetProgressMeterView_Previews: PreviewProvider {
  static var previews: some View {
    WidgetProgressMeterView(
      label: "Fasted state hours this week",
      systemImage: "gauge",
      amount: 12.1,
      min: .zero,
      max: 24,
      progressColor: .purple
    )
    .previewContext(WidgetPreviewContext(family: .accessoryCircular))
  }
}
