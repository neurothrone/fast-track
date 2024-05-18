import SwiftUI

struct LogSectionedListRowView: View {
  let yearWeekLabel: String
  let totalFastedStateDuration: Double
  
  var body: some View {
    HStack {
      Text(yearWeekLabel)
        .foregroundColor(.mint)
      
      Spacer()
      
      Text("\(String(format: "%.1f", totalFastedStateDuration)) h")
        .foregroundColor(.purple)
    }
  }
}

struct LogSectionedListRowView_Previews: PreviewProvider {
  static var previews: some View {
    LogSectionedListRowView(
      yearWeekLabel: "2022 (Week 49)",
      totalFastedStateDuration: 29.2
    )
  }
}
