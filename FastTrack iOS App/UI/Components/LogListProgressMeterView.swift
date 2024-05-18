import SwiftUI

struct LogListProgressMeterView: View {
  let label: String
  let systemImage: String

  let amount: Double
  let min: Double
  let max: Double
  
  let progressColor: Color
  
  var body: some View {
    Section {
      ProgressMeterView(
        label: label,
        systemImage: systemImage,
        amount: amount,
        min: min,
        max: max,
        progressColor: progressColor
      )
      .listRowBackground(
        EmptyView()
          .background(.thickMaterial)
      )
    }
  }
}

struct LogListProgressMeterView_Previews: PreviewProvider {
  static var previews: some View {
    LogListProgressMeterView(
      label: "Fasted state hours this week",
      systemImage: "gauge",
      amount: 12.1,
      min: .zero,
      max: 24,
      progressColor: .purple
    )
  }
}
