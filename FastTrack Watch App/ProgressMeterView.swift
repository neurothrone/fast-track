import SwiftUI

struct ProgressMeterView: View {
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
#if os(iOS)
      .gaugeStyle(.accessoryCircular)
#elseif os(watchOS)
      .gaugeStyle(.circular)
#endif
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
      max: 24,
      progressColor: .purple
    )
  }
}
